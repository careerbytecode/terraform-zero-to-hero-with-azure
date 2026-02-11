
---

---

# 📁 Day 12 — Azure App Service Deployment

# Deploy Azure App Service with Terraform

Today I deployed a production-style web app using Infrastructure as Code.

No portal.
Just Terraform.

---

## 🚀 What this deploys

✔ Resource Group  
✔ App Service Plan  
✔ App Service (Linux)  
✔ Runtime configuration

---

## 🧠 Real-world use case

Perfect for:
- internal tools
- APIs
- small apps
- microservices

Deploy dev/test/prod instantly.

---

## 🏗 Architecture

App Service Plan
↓
App Service
↓
Web Application

---

## ⚙️ Run

```bash
terraform init
terraform apply
