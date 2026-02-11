# 🏗️ Day 5 — Deploy Resource Group + Storage Account

Today’s session expanded from basics into real Azure resources by deploying a **Resource Group** and **Storage Account** using Terraform.

---

## 📦 Resources Deployed

- Azure Resource Group
- Azure Storage Account

These represent the building blocks that future infra depends on.

---

## 🧩 Terraform Code Example

```hcl
# Create a Resource Group
resource "azurerm_resource_group" "rg_storage_stag_eastus_001" {
  name     = "rg-storage-stag-eastus-001"
  location = "eastus"
}
# Create a Storage Account
resource "azurerm_storage_account" "storage_stag_eastus_001" {
  name                     = "storagestageastus001"
  resource_group_name      = azurerm_resource_group.rg_storage_stag_eastus_001.name
  location                 = azurerm_resource_group.rg_storage_stag_eastus_001.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags = {
    environment = "staging"
  }
}
