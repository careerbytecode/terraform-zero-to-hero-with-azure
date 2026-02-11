# Create a Resource Group
resource "azurerm_resource_group" "rg_vnet_day_07" {
  name     = "rg-vnet-${var.project_name}-${var.environment}-day-07"
  location = var.location
}
# Virtual Network
resource "azurerm_virtual_network" "vnet_day_07" {
  name                = "vnet-${var.project_name}-${var.environment}-day-07"
  address_space       = [var.vnet_cidr]
  location            = azurerm_resource_group.rg_vnet_day_07.location
  resource_group_name = azurerm_resource_group.rg_vnet_day_07.name
}
# Public Subnet
resource "azurerm_subnet" "public_subnet_day_07" {
  name                 = "snet-public-${var.project_name}-${var.environment}-day-07"
  resource_group_name  = azurerm_resource_group.rg_vnet_day_07.name
  virtual_network_name = azurerm_virtual_network.vnet_day_07.name
  address_prefixes     = [var.public_subnet_cidr]
}
# Private Subnet
resource "azurerm_subnet" "private_subnet_day_07" {
  name                 = "snet-private-${var.project_name}-${var.environment}-day-07"
  resource_group_name  = azurerm_resource_group.rg_vnet_day_07.name
  virtual_network_name = azurerm_virtual_network.vnet_day_07.name
  address_prefixes     = [var.private_subnet_cidr]
}
# Network Security Group
resource "azurerm_network_security_group" "nsg_public_day_07" {
  name                = "nsg-public-${var.project_name}-${var.environment}-day-07"
  location            = azurerm_resource_group.rg_vnet_day_07.location
  resource_group_name = azurerm_resource_group.rg_vnet_day_07.name
}
# Allow HTTP inbound
resource "azurerm_network_security_rule" "allow_http_inbound" {
  name                        = "Allow-HTTP-Inbound"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg_vnet_day_07.name
  network_security_group_name = azurerm_network_security_group.nsg_public_day_07.name
}
# Associate NSG with public subnet
resource "azurerm_subnet_network_security_group_association" "public_subnet_nsg_assoc" {
  subnet_id                 = azurerm_subnet.public_subnet_day_07.id
  network_security_group_id = azurerm_network_security_group.nsg_public_day_07.id
}

