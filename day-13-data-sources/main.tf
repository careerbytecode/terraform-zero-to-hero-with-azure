locals {
  prefix = "${var.project_name}-${var.environment}"
}
# READ existing infra (DATA
data "azurerm_resource_group" "rg" {
  name = var.existing_rg_name
}
data "azurerm_virtual_network" "vnet" {
  name                = var.existing_vnet_name
  resource_group_name = data.azurerm_resource_group.rg.name
}

# Create NEW subnet (Terraform managed)
resource "azurerm_subnet" "terraform_subnet" {
  name                 = "snet-${local.prefix}-app"
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  address_prefixes     = [var.subnet_cidr]

  delegation {
    name = "appservice-delegation"

    service_delegation {
      name = "Microsoft.Web/serverFarms"

      actions = [
        "Microsoft.Network/virtualNetworks/subnets/action"
      ]
    }
  }
}
# CREATE only app service

resource "azurerm_service_plan" "plan" {
  name                = "plan-${local.prefix}"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  os_type  = "Windows" # change to Linux for Linux Web App
  sku_name = "B1"
}

# =========================
# Windows Web App
# =========================
resource "azurerm_windows_web_app" "app" {
  name                = "app-${local.prefix}"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  service_plan_id     = azurerm_service_plan.plan.id

  https_only = true

  site_config {
    always_on = false

    application_stack {
      current_stack  = "dotnet"
      dotnet_version = "v8.0"
    }
  }

  app_settings = {
    "SCM_DO_BUILD_DURING_DEPLOYMENT" = "true" # Enable build during deployment
    "WEBSITE_RUN_FROM_PACKAGE"       = "0"    # Allow deployment to extract files
  }
  virtual_network_subnet_id = azurerm_subnet.terraform_subnet.id
}
# GitHub Source Control Integration
resource "azurerm_app_service_source_control" "github" {
  app_id   = azurerm_windows_web_app.app.id
  repo_url = var.github_repo_url
  branch   = "master"

  use_manual_integration = true
}
