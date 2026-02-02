terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.58.0"
    }
  }
}
provider "azurerm" {
  subscription_id = "19644874-3e1c-4f4a-8d5f-2901769bf6a7"
  features {}
}
# Create a Resource Group
resource "azurerm_resource_group" "rg_storage_stag_eastus_001" {
  name     = "rg-storage-stag-eastus-001"
  location = "eastus"
}
# Create a Storage Account
resource "azurerm_storage_account" "storage_stag_eastus_001" {
  name                     = "storagestageastus001"
  resource_group_name      = azurerm_resource_group.rg_storage_stag_eastus_001.name
  location                 = azurerm_resource_group.rg_storage_stag_eastus_001.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags = {
    environment = "staging"
  }
}


