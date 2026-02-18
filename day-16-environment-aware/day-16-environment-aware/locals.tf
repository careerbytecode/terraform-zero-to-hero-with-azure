locals {
  common_tags = {
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "Terraform"
    Owner       = "Solutions Architect"
    Day         = "16"
  }

  # Environment tier classification
  environment_tier = var.environment == "prod" ? "Critical" : "Non-Critical"

  # App Service SKU selection based on environment
  app_service_sku = var.environment == "prod" ? "P1v2" : (
    var.environment == "stag" ? "S1" : "B1"
  )

  # Always On feature (not available in Basic tier)
  enable_always_on = var.environment == "prod" ? true : false

  # Database SKU selection
  database_sku = var.environment == "prod" ? "S3" : (
    var.environment == "stag" ? "S0" : "Basic"
  )

  # Database size in GB
  database_max_size = var.environment == "prod" ? 250 : (
    var.environment == "stag" ? 100 : 2
  )

  # Storage replication type
  storage_replication_type = var.environment == "prod" ? "GRS" : "LRS"

  # Application Insights retention
  app_insights_retention = var.environment == "prod" ? 90 : (
    var.environment == "stag" ? 60 : 30
  )

  # Logging level
  log_level = var.environment == "prod" ? "Warning" : (
    var.environment == "stag" ? "Information" : "Debug"
  )

  # Enable detailed logs (only for non-prod)
  enable_detailed_logs = var.environment == "prod" ? "false" : "true"

  # Connection timeout (seconds)
  connection_timeout = var.environment == "prod" ? "60" : "30"

  # Computed monthly costs (approximate)
  estimated_monthly_cost = var.environment == "prod" ? 300 : (
    var.environment == "stag" ? 120 : 25
  )
}
