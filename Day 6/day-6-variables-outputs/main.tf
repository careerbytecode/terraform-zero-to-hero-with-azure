# Create a Resource Group
resource "azurerm_resource_group" "rg_storage_stag_eastus_001" {
  name     = var.resource_group_name
  location = var.location
}
# Create a Storage Account
resource "azurerm_storage_account" "storage_stag_eastus_001" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.rg_storage_stag_eastus_001.name
  location                 = azurerm_resource_group.rg_storage_stag_eastus_001.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags = {
    environment = var.environment
  }
}
