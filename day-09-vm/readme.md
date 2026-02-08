# Day 9 – Deploy a Linux VM with Terraform (Azure)

Today I deployed a complete Linux VM stack using Terraform instead of clicking through the Azure Portal.

Goal: Provision everything needed for a VM in **one command**.

---

## 🚀 What this deploys

✔ Resource Group  
✔ Virtual Network  
✔ Subnet  
✔ Network Security Group  
✔ Public IP  
✔ NIC  
✔ Linux VM (Ubuntu)

---

## 🧠 Real-world scenario

Imagine:
- spinning up test servers
- creating dev environments
- provisioning client demo machines

Doing this manually takes ~15–20 minutes per VM.

Terraform → **~2 minutes + reusable forever**

---

## 🏗 Architecture

VM
↓  
NIC  
↓  
Subnet  
↓  
VNet  
↓  
NSG

---

## 📂 Project Structure

.  
├── main.tf  
├── variables.tf  
├── outputs.tf  
└── terraform.tfvars

---

## ⚙️ How to run

```bash
terraform init
terraform plan
terraform apply
```
Destroy when done:

```bash
terraform destroy
```


