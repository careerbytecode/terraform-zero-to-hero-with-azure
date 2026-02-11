output "resource_group_name" {
  value = azurerm_resource_group.rg_vnet_day_07.name
}

output "vnet_name" {
  value = azurerm_virtual_network.vnet_day_07.name
}

output "public_subnet_id" {
  value = azurerm_subnet.public_subnet_day_07.id
}

output "private_subnet_id" {
  value = azurerm_subnet.private_subnet_day_07.id
}
