terraform {
  backend "azurerm" {
    resource_group_name = "tfstatetfh"
    storage_account_name = "tfstatetfh"
    container_name = "tfstate"
    key = "day10.tfstate"
    
  }
}