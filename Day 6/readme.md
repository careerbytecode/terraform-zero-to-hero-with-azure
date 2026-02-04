# Day 6 – Terraform Variables & Outputs (Reusable Infrastructure)

Part of my **30-Day Terraform + Azure Challenge**

Today’s focus:  
Turning hard-coded Terraform into **reusable, environment-agnostic infrastructure**

---

## 🎯 Goal

Instead of writing Terraform like this:

❌ Hardcoded names  
❌ Fixed region  
❌ Duplicate files per environment  
❌ Manual edits everywhere  

We refactor to:

✅ Input variables  
✅ Dynamic naming  
✅ Environment-based configs  
✅ Outputs for easy integrations  
✅ One codebase → multiple environments  

---

## 🧠 What I Built

This project deploys:

- Azure Resource Group
- Azure Storage Account

But now it is:
- configurable
- reusable
- production-style

Same code works for:
- dev
- test
- prod

Just by changing variables.

---

## 📁 Project Structure

```
day-6-variables-outputs/
│
├── main.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars
├── provider.tf
└── README.md
```


---

## ⚙️ Variables Used

| Name | Description | Example |
|------|-------------|-----------|
| project_name | Project identifier | tfzerohero |
| environment | Environment name | staging |
| location | Azure region | eastus |

---

## 📦 Example Code

### variables.tf
```hcl
variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "location" {
  type = string
}

