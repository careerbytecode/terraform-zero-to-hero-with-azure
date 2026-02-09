
---

---

# 📁 Day 10 — Remote State Management

# Terraform State Management (Local vs Remote)

Today I learned why Terraform state is critical for real-world teams.

Local state works for learning.
Remote state is required for collaboration.

---

## 🚨 Problem

Local state:  
❌ not shareable  
❌ easy to lose  
❌ no locking  
❌ conflicts in teams

---

## ✅ Solution

Store state in Azure Storage Account.

Benefits:  
✔ shared  
✔ remote  
✔ locked  
✔ safer for teams

---

## 🏗 Resources created

✔ Resource Group  
✔ Storage Account  
✔ Blob Container  
✔ Remote backend configuration

---

## ⚙️ Backend configuration

```hcl
terraform {
  backend "azurerm" {
    resource_group_name  = "rg-tfstate"
    storage_account_name = "tfstateprod"
    container_name       = "state"
    key                  = "day10.tfstate"
  }
}
```
## ⚙️ Commands
```bash
terraform init   # migrates local state → remote
terraform apply
```
## 🎯 Key Learnings
✔ Remote state is mandatory for teams  
✔ Prevents accidental overwrites  
✔ Enables safe CI/CD
## 💡 Takeaway

Infrastructure without state management is risky automation.
