# Day 16: Environment-Aware Infrastructure
# Demonstrating conditional expressions and environment-specific configurations

# Resource Group
resource "azurerm_resource_group" "main" {
  name     = "rg-${var.project_name}-${var.environment}"
  location = var.location

  tags = local.common_tags
}

# App Service Plan - SKU changes based on environment
resource "azurerm_service_plan" "main" {
  name                = "asp-${var.project_name}-${var.environment}"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  os_type             = "Linux"

  # Environment-aware SKU selection
  # dev/test: B1 (Basic) - $13/month
  # staging: S1 (Standard) - $70/month
  # production: P1v2 (Premium) - $150/month
  sku_name = local.app_service_sku

  tags = local.common_tags
}

# Linux Web App with environment-specific settings
resource "azurerm_linux_web_app" "main" {
  name                = "app-${var.project_name}-${var.environment}-${random_string.unique.result}"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  service_plan_id     = azurerm_service_plan.main.id

  site_config {
    # Production gets more instances
    minimum_tls_version = "1.2"

    # Always On only for production (costs extra in Basic tier)
    always_on = local.enable_always_on

    application_stack {
      dotnet_version = "7.0"
    }

    # HTTPS only enforced in production
    ftps_state = var.environment == "production" ? "Disabled" : "AllAllowed"
  }

  app_settings = {
    "ENVIRONMENT"          = var.environment
    "LOG_LEVEL"            = local.log_level
    "ENABLE_DETAILED_LOGS" = local.enable_detailed_logs
    "CONNECTION_TIMEOUT"   = local.connection_timeout
  }

  # Environment-specific scaling
  tags = merge(
    local.common_tags,
    {
      Tier        = local.environment_tier
      Cost_Center = var.environment == "production" ? "Production" : "Non-Production"
    }
  )
}

# Azure SQL Server
resource "azurerm_mssql_server" "main" {
  name                         = "sql-${var.project_name}-${var.environment}-${random_string.unique.result}"
  resource_group_name          = azurerm_resource_group.main.name
  location                     = azurerm_resource_group.main.location
  version                      = "12.0"
  administrator_login          = var.sql_admin_username
  administrator_login_password = var.sql_admin_password

  # Production requires Azure AD authentication
 dynamic "azuread_administrator" {
  for_each = var.environment == "production" ? [1] : []

  content {
    login_username = var.aad_admin_login
    object_id      = var.aad_admin_object_id
  }
}

  tags = local.common_tags
}

# Azure SQL Database - Size varies by environment
resource "azurerm_mssql_database" "main" {
  name      = "sqldb-${var.project_name}-${var.environment}"
  server_id = azurerm_mssql_server.main.id

  # Environment-aware database sizing
  # dev: Basic (2GB) - $5/month
  # staging: S0 (250GB) - $15/month  
  # production: S3 (250GB) - $100/month
  sku_name    = local.database_sku
  max_size_gb = local.database_max_size

  # Production gets geo-replication
  zone_redundant = var.environment == "production" ? true : false

  tags = local.common_tags
}

# Storage Account - Replication type based on environment
resource "azurerm_storage_account" "main" {
  name                = "st${var.project_name}${var.environment}${random_string.unique.result}"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  account_tier        = "Standard"

  # dev/staging: LRS (Locally Redundant)
  # production: GRS (Geo-Redundant)
  account_replication_type = local.storage_replication_type

  # Production requires encryption
  min_tls_version = var.environment == "production" ? "TLS1_2" : "TLS1_0"

  tags = local.common_tags
}

# Application Insights - Retention period varies
resource "azurerm_application_insights" "main" {
  name                = "appi-${var.project_name}-${var.environment}"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  application_type    = "web"

  # dev: 30 days, staging: 60 days, production: 90 days
  retention_in_days = local.app_insights_retention

  tags = local.common_tags
}

# Log Analytics Workspace - Only for production
resource "azurerm_log_analytics_workspace" "main" {
  count = var.environment == "production" ? 1 : 0

  name                = "log-${var.project_name}-${var.environment}"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  sku                 = "PerGB2018"
  retention_in_days   = 90

  tags = local.common_tags
}

# Random string for unique naming
resource "random_string" "unique" {
  length  = 6
  special = false
  upper   = false
}
