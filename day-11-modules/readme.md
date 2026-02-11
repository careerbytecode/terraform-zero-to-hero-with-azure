
---

---

# 📁 Day 11 — Terraform Modules

# Terraform Modules (Reusable Infrastructure)

Today I stopped copy-pasting Terraform code and started building reusable modules.

Modules = functions for infrastructure.

---

## 🚀 Goal

Make code:  
✔ reusable   
✔ cleaner  
✔ scalable  
✔ DRY

---

## Before modules

- repeated network blocks
- duplicated VM configs
- messy files

---

## After modules

Reusable components:  

modules/  
├── network/  
├── vm/

---

## Example usage

```hcl
module "network" {
  source = "./modules/network"
  vnet_name = "demo-vnet"
}

module "vm" {
  source = "./modules/vm"
  vm_name = "demo-vm"
}

