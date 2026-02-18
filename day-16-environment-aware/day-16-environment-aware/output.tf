
output "app_service_url" {
  description = "URL of the App Service"
  value       = "https://${azurerm_linux_web_app.main.default_hostname}"
}

output "resource_details" {
  description = "Deployed resource details"
  value = {
    resource_group   = azurerm_resource_group.main.name
    app_service_name = azurerm_linux_web_app.main.name
    sql_server_fqdn  = azurerm_mssql_server.main.fully_qualified_domain_name
    database_name    = azurerm_mssql_database.main.name
    storage_account  = azurerm_storage_account.main.name
    app_insights     = azurerm_application_insights.main.name
    log_analytics    = var.environment == "production" ? azurerm_log_analytics_workspace.main[0].name : "Not deployed (non-production)"
  }
}

output "environment_features" {
  description = "Features enabled for this environment"
  value = {
    always_on             = local.enable_always_on
    zone_redundant_db     = var.environment == "production"
    geo_redundant_storage = local.storage_replication_type == "GRS"
    log_analytics         = var.environment == "production"
    log_retention_days    = local.app_insights_retention
    log_level             = local.log_level
  }
}
output "z_environment_configuration" {
  description = "Active environment configuration"
  value = {
    environment         = var.environment
    tier                = local.environment_tier
    app_service_sku     = local.app_service_sku
    database_sku        = local.database_sku
    storage_replication = local.storage_replication_type
    estimated_cost      = format("$%.2f/month", local.estimated_monthly_cost)
  }
}
output "z_cost_optimization_summary" {
  description = "Cost optimization applied"
  value = {
    environment       = var.environment
    app_service_tier  = local.app_service_sku
    database_tier     = local.database_sku
    estimated_monthly = format("$%.2f", local.estimated_monthly_cost)
    savings_vs_prod = var.environment != "production" ? format("~%.0f%% lower cost", 100 - (local.estimated_monthly_cost * 100 / 300)) : "Full production features"
  }
}

