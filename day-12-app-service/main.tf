locals {
  name_prefix = "${var.project_name}-${var.environment}"
}

# =========================
# Resource Group
# =========================
resource "azurerm_resource_group" "rg" {
  name     = "rg-${local.name_prefix}"
  location = var.location
}

# =========================
# App Service Plan (compute)
# =========================
resource "azurerm_service_plan" "plan" {
  name                = "asp-${local.name_prefix}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  os_type  = "Windows" # change to Linux for Linux Web App
  sku_name = "B1"      # cheap for learning
}

# =========================
# Windows Web App
# =========================
resource "azurerm_windows_web_app" "app" {
  name                = "app-${local.name_prefix}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_service_plan.plan.id

  https_only = true

  site_config {
    always_on = false

    application_stack {
      current_stack  = "dotnet"
      dotnet_version = "v8.0"
      # For Linux Web App, use below block instead of above
      # linux_fx_version = "NODE|18-lts"
      # change if python/dotnet needed
    }
  }

  app_settings = {
    "SCM_DO_BUILD_DURING_DEPLOYMENT" = "true" # Enable build during deployment
    "WEBSITE_RUN_FROM_PACKAGE"       = "0"    # Allow deployment to extract files
  }
}

# =========================
# GitHub Source Control Integration
# =========================
resource "azurerm_app_service_source_control" "github" {
  app_id   = azurerm_windows_web_app.app.id
  repo_url = var.github_repo_url
  branch   = "master"

  use_manual_integration = true
}
