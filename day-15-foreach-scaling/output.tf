output "subnet_ids" {
  description = "Map of subnet names to IDs"
  value = {
    for key, subnet in azurerm_subnet.subnets : key => subnet.id
  }
}

output "subnet_details" {
  description = "Detailed subnet information"
  value = {
    for key, subnet in azurerm_subnet.subnets : key => {
      id                = subnet.id
      address_prefix    = subnet.address_prefixes[0]
      service_endpoints = subnet.service_endpoints
    }
  }
}

output "nsg_ids" {
  description = "Map of NSG names to IDs"
  value = {
    for key, nsg in azurerm_network_security_group.nsgs : key => nsg.id
  }
}

output "storage_account_endpoints" {
  description = "Storage account primary endpoints"
  value = {
    for key, storage in azurerm_storage_account.storage : key => {
      location              = storage.location
      primary_blob_endpoint = storage.primary_blob_endpoint
      replication_type      = storage.account_replication_type
    }
  }
}

output "total_resources_created" {
  description = "Total number of subnets and storage accounts created dynamically"
  value = {
    subnets          = length(azurerm_subnet.subnets)
    nsgs             = length(azurerm_network_security_group.nsgs)
    storage_accounts = length(azurerm_storage_account.storage)
  }
}
