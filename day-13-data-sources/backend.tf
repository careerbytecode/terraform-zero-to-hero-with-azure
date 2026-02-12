terraform {
  backend "azurerm" {
    resource_group_name  = "rg-tfstate"
    storage_account_name = "tfstatet"
    container_name       = "tfstate"
    key                  = "day13.tfstate"

  }
}