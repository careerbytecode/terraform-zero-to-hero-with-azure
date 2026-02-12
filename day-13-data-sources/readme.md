
---

---

# 📁 Day 13 — Terraform Data Sources

# Terraform Data Sources (Using Existing Infrastructure)

Today I learned how to reference existing Azure resources instead of creating new ones.

Real environments already have shared infra.

Terraform must integrate, not duplicate.

---

## 🚀 When to use data sources

✔ existing resource groups  
✔ shared VNets  
✔ central storage  
✔ key vaults

---

## Example

```hcl
data "azurerm_resource_group" "existing" {
  name = "shared-rg"
}

