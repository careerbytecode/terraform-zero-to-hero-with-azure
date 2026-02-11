resource "azurerm_resource_group" "rg" {
  name     = "rg-${var.project_name}-${var.environment}-${var.suffix}"
  location = var.location
}
# Call network module ONCE
module "network" {
  source             = "./modules/network"
  project_name       = var.project_name
  environment        = var.environment
  suffix             = var.suffix
  location           = var.location
  rg_name            = azurerm_resource_group.rg.name
  vnet_cidr          = var.vnet_cidr
  public_subnet_cidr = var.public_subnet_cidr
}
# Call vm module MULTIPLE TIMES
module "dev_vm" {
  source             = "./modules/vm"
  vm_name            = "dev-vm"
  location           = var.location
  rg_name            = azurerm_resource_group.rg.name
  vnet_cidr          = var.vnet_cidr
  public_subnet_cidr = var.public_subnet_cidr
  subnet_id          = module.network.subnet_id
  admin_password     = var.admin_password
  project_name       = var.project_name
  environment        = var.environment
  suffix             = var.suffix
}
module "qa_vm" {
  source             = "./modules/vm"
  vm_name            = "qa-vm"
  location           = var.location
  rg_name            = azurerm_resource_group.rg.name
  vnet_cidr          = var.vnet_cidr
  public_subnet_cidr = var.public_subnet_cidr
  subnet_id          = module.network.subnet_id
  admin_password     = var.admin_password
  project_name       = var.project_name
  environment        = var.environment
  suffix             = var.suffix
}
module "prod_vm" {
  source             = "./modules/vm"
  vm_name            = "prod-vm"
  location           = var.location
  rg_name            = azurerm_resource_group.rg.name
  subnet_id          = module.network.subnet_id
  vnet_cidr          = var.vnet_cidr
  public_subnet_cidr = var.public_subnet_cidr
  admin_password     = var.admin_password
  project_name       = var.project_name
  environment        = var.environment
  suffix             = var.suffix
}
