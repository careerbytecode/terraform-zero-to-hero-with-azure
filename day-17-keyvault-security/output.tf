output "key_vault_name" {
  description = "Name of the Key Vault"
  value       = azurerm_key_vault.main.name
}

output "key_vault_uri" {
  description = "URI of the Key Vault"
  value       = azurerm_key_vault.main.vault_uri
}

output "app_service_url" {
  description = "URL of the App Service"
  value       = "https://${azurerm_linux_web_app.main.default_hostname}"
}

output "app_service_identity" {
  description = "Managed Identity of the App Service"
  value = {
    principal_id = azurerm_linux_web_app.main.identity[0].principal_id
    tenant_id    = azurerm_linux_web_app.main.identity[0].tenant_id
  }
}

output "secrets_stored" {
  description = "Secrets stored in Key Vault"
  value = {
    sql_password          = azurerm_key_vault_secret.sql_password.name
    sql_connection_string = azurerm_key_vault_secret.sql_connection_string.name
    storage_key           = azurerm_key_vault_secret.storage_key.name
  }
}

output "security_features" {
  description = "Security features enabled"
  value = {
    managed_identity_enabled = true
    key_vault_integration    = true
    rbac_authorization       = azurerm_key_vault.main.rbac_authorization_enabled
    tls_version              = "1.2"
    soft_delete_retention    = "${azurerm_key_vault.main.soft_delete_retention_days} days"
    purge_protection         = azurerm_key_vault.main.purge_protection_enabled
    no_hardcoded_secrets     = true
  }
}

output "sql_server_fqdn" {
  description = "SQL Server FQDN (password stored in Key Vault)"
  value       = azurerm_mssql_server.main.fully_qualified_domain_name
}

output "how_to_access_secrets" {
  description = "Instructions for accessing secrets"
  value       = <<-EOT
    Access secrets using Azure CLI:
    
    1. View secret names:
       az keyvault secret list --vault-name ${azurerm_key_vault.main.name}
    
    2. Retrieve SQL password:
       az keyvault secret show --vault-name ${azurerm_key_vault.main.name} --name sql-admin-password --query value -o tsv
    
    3. Retrieve connection string:
       az keyvault secret show --vault-name ${azurerm_key_vault.main.name} --name sql-connection-string --query value -o tsv
    
    Note: App Service uses Managed Identity - no manual credential management needed!
  EOT
}
