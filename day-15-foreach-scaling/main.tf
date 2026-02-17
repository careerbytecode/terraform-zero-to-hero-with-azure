# Day 15: Scalable Infrastructure with for_each
# Demonstrating dynamic resource provisioning using maps and loops


# Resource Group
resource "azurerm_resource_group" "main" {
  name     = "rg-${var.project_name}-${var.environment}"
  location = var.location
  tags     = local.common_tags
}

# Virtual Network
resource "azurerm_virtual_network" "main" {
  name                = "vnet-${var.project_name}-${var.environment}"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  address_space       = ["10.0.0.0/16"]

  tags = local.common_tags
}

# BEFORE: Manual subnet creation (commented out to show the problem)
# resource "azurerm_subnet" "web" {
#   name                 = "subnet-web"
#   resource_group_name  = azurerm_resource_group.main.name
#   virtual_network_name = azurerm_virtual_network.main.name
#   address_prefixes     = ["10.0.1.0/24"]
# }

# resource "azurerm_subnet" "app" {
#   name                 = "subnet-app"
#   resource_group_name  = azurerm_resource_group.main.name
#   virtual_network_name = azurerm_virtual_network.main.name
#   address_prefixes     = ["10.0.2.0/24"]
# }

# resource "azurerm_subnet" "data" {
#   name                 = "subnet-data"
#   resource_group_name  = azurerm_resource_group.main.name
#   virtual_network_name = azurerm_virtual_network.main.name
#   address_prefixes     = ["10.0.3.0/24"]
# }

# AFTER: Dynamic subnet creation with for_each
resource "azurerm_subnet" "subnets" {
  for_each = local.subnets

  name                 = "subnet-${each.key}"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = [each.value.address_prefix]

  # Dynamic service endpoints based on subnet type
  service_endpoints = each.value.service_endpoints
}

# Network Security Groups - also using for_each
resource "azurerm_network_security_group" "nsgs" {
  for_each = local.subnets

  name                = "nsg-${each.key}-${var.environment}"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  tags = merge(
    local.common_tags,
    {
      Tier = each.key
    }
  )
}

# NSG Rules using for_each with dynamic rules
resource "azurerm_network_security_rule" "allow_https" {
  for_each = local.subnets

  name                        = "AllowHTTPS"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.main.name
  network_security_group_name = azurerm_network_security_group.nsgs[each.key].name
}

# Associate NSGs with Subnets
resource "azurerm_subnet_network_security_group_association" "nsg_associations" {
  for_each = local.subnets

  subnet_id                 = azurerm_subnet.subnets[each.key].id
  network_security_group_id = azurerm_network_security_group.nsgs[each.key].id
}

# Storage Accounts - Multiple regions using for_each
resource "azurerm_storage_account" "storage" {
  for_each = local.storage_accounts

  name                     = "st${var.project_name}${each.key}${random_string.unique.result}"
  resource_group_name      = azurerm_resource_group.main.name
  location                 = each.value.location
  account_tier             = each.value.tier
  account_replication_type = each.value.replication

  tags = merge(
    local.common_tags,
    {
      Region  = each.value.location
      Purpose = each.value.purpose
    }
  )
}

# Random string for unique naming
resource "random_string" "unique" {
  length  = 6
  special = false
  upper   = false
}
