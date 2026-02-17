locals {
  common_tags = {
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "Terraform"
    Owner       = "Solutions Architect"
    Day         = "15"
  }

  # Subnet configuration using map
  # Adding a new subnet? Just add one entry here!
  subnets = {
    web = {
      address_prefix    = "10.0.1.0/24"
      service_endpoints = ["Microsoft.Web"]
    }
    app = {
      address_prefix    = "10.0.2.0/24"
      service_endpoints = ["Microsoft.Web", "Microsoft.KeyVault"]
    }
    data = {
      address_prefix    = "10.0.3.0/24"
      service_endpoints = ["Microsoft.Sql", "Microsoft.Storage"]
    }
    # To add a new subnet, just add a new block:
    management = {
      address_prefix    = "10.0.4.0/24"
      service_endpoints = ["Microsoft.Storage"]
    }
  }

  # Storage account configuration for multiple regions
  # Expanding to new regions? Just add here!
  storage_accounts = {
    primary = {
      location    = var.location
      tier        = "Standard"
      replication = "LRS"
      purpose     = "Primary storage"
    }
    backup = {
      location    = var.backup_location
      tier        = "Standard"
      replication = "GRS"
      purpose     = "Backup storage"
    }
    # To add a new region:
    # disaster_recovery = {
    #   location    = "West Europe"
    #   tier        = "Standard"
    #   replication = "GRS"
    #   purpose     = "DR storage"
    # }
  }
}
