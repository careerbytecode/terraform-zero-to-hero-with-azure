# Get current client for Key Vault access
data "azurerm_client_config" "current" {}
# Resource Group
resource "azurerm_resource_group" "main" {
  name     = "rg-${var.project_name}-${var.environment}"
  location = var.location

  tags = local.common_tags
}
# Key Vault - Central secrets management
resource "azurerm_key_vault" "main" {
  name                = "kv-${var.project_name}-${random_string.unique.result}"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"
  # Security features
  soft_delete_retention_days = 7
  purge_protection_enabled   = var.environment == "production" ? true : false

  # RBAC-based access (modern approach)
  rbac_authorization_enabled = true

  # Network rules (production should be restricted)
  network_acls {
    bypass         = "AzureServices"
    default_action = var.environment == "production" ? "Deny" : "Allow"
  }

  tags = local.common_tags
}
# Generate secure random password
resource "random_password" "sql_password" {
  length  = 24
  special = true
  upper   = true
  lower   = true
  numeric = true
}
# RBAC: Grant current user Key Vault Administrator role
resource "azurerm_role_assignment" "current_user_kv_admin" {
  scope                = azurerm_key_vault.main.id
  role_definition_name = "Key Vault Administrator"
  principal_id         = data.azurerm_client_config.current.object_id

}
# Azure SQL Server
resource "azurerm_mssql_server" "main" {
  name                         = "sql-${var.project_name}-${var.environment}-${random_string.unique.result}"
  resource_group_name          = azurerm_resource_group.main.name
  location                     = azurerm_resource_group.main.location
  version                      = "12.0"
  administrator_login          = var.sql_admin_username
  administrator_login_password = random_password.sql_password.result

  # Enable Azure AD authentication
  azuread_administrator {
    login_username = data.azurerm_client_config.current.object_id
    object_id      = data.azurerm_client_config.current.object_id
  }

  tags = local.common_tags
}
# Azure SQL Database
resource "azurerm_mssql_database" "main" {
  name      = "sqldb-${var.project_name}-${var.environment}"
  server_id = azurerm_mssql_server.main.id
  sku_name  = "Basic"

  tags = local.common_tags
}
# Store SQL password in Key Vault (NOT in code!)
resource "azurerm_key_vault_secret" "sql_password" {
  name         = "sql-admin-password"
  value        = random_password.sql_password.result
  key_vault_id = azurerm_key_vault.main.id
  depends_on = [
    azurerm_role_assignment.current_user_kv_admin
  ]
  tags = local.common_tags
}
# Store SQL connection string in Key Vault
resource "azurerm_key_vault_secret" "sql_connection_string" {
  name  = "sql-connection-string"
  value = "Server=tcp:${azurerm_mssql_server.main.fully_qualified_domain_name},1433;Initial Catalog=${azurerm_mssql_database.main.name};Persist Security Info=False;User ID=${var.sql_admin_username};Password=${random_password.sql_password.result};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"

  key_vault_id = azurerm_key_vault.main.id
  depends_on = [
    azurerm_role_assignment.current_user_kv_admin
  ]
  tags = local.common_tags
}

# App Service Plan
resource "azurerm_service_plan" "main" {
  name                = "asp-${var.project_name}-${var.environment}"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  os_type             = "Linux"
  sku_name            = "B1"

  tags = local.common_tags
}
# App Service with Managed Identity
resource "azurerm_linux_web_app" "main" {
  name                = "app-${var.project_name}-${var.environment}-${random_string.unique.result}"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  service_plan_id     = azurerm_service_plan.main.id

  # Enable System-Assigned Managed Identity
  identity {
    type = "SystemAssigned"
  }

  site_config {
    application_stack {
      dotnet_version = "8.0"
    }

    # Security headers
    ftps_state          = "Disabled"
    http2_enabled       = true
    minimum_tls_version = "1.2"
  }

  # Reference Key Vault secrets using managed identity
  app_settings = {
    "ENVIRONMENT"    = var.environment
    "KEY_VAULT_NAME" = azurerm_key_vault.main.name

    # Using Key Vault references instead of hardcoded values
    # Format: @Microsoft.KeyVault(SecretUri=<secret-uri>)
    "SQL_CONNECTION_STRING" = "@Microsoft.KeyVault(SecretUri=${azurerm_key_vault_secret.sql_connection_string.id})"

    # App can also retrieve secrets programmatically using Azure.Identity SDK
    "KEY_VAULT_URI" = azurerm_key_vault.main.vault_uri
  }

  tags = local.common_tags
}
# Grant App Service Managed Identity access to Key Vault
resource "azurerm_role_assignment" "app_kv_secrets_user" {
  scope                = azurerm_key_vault.main.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azurerm_linux_web_app.main.identity[0].principal_id
}
# Storage Account with encryption
resource "azurerm_storage_account" "main" {
  name                     = "st${var.project_name}${random_string.unique.result}"
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  # Security features
  min_tls_version = "TLS1_2"
  # https_traffic_only_enabled       = true
  allow_nested_items_to_be_public = false

  tags = local.common_tags
}
# Store Storage Account key in Key Vault
resource "azurerm_key_vault_secret" "storage_key" {
  name         = "storage-account-key"
  value        = azurerm_storage_account.main.primary_access_key
  key_vault_id = azurerm_key_vault.main.id
  depends_on = [
    azurerm_role_assignment.current_user_kv_admin
  ]

  tags = local.common_tags
}

# Random string for unique naming
resource "random_string" "unique" {
  length  = 6
  special = false
  upper   = false
}

