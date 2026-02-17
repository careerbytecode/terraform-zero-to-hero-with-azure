terraform {
  backend "azurerm" {
    resource_group_name  = "rg-tfstate"
    storage_account_name = "tfstatehero"
    container_name       = "tfstate"
    key                  = "day15.tfstate"

  }
}