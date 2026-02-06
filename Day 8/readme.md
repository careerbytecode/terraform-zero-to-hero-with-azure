# Day 8 – Azure Networking with Terraform (VNet, Subnets, NSGs)

Part of my **30-Day Terraform + Azure Challenge**

Today’s focus:  
Building a **secure, production-style Azure network using Infrastructure as Code**.

---

## 🎯 Objective

Move beyond single resources and start designing **real cloud architecture**.

Instead of:
❌ Deploying isolated resources

We design:
✅ Network structure
✅ Segmentation
✅ Security boundaries
✅ Reusable infrastructure

Because in real-world cloud systems…

👉 Networking is the foundation of everything.

---

## 🧠 What This Project Deploys

Terraform provisions:

- Resource Group
- Virtual Network (VNet)
- Public Subnet
- Private Subnet
- Network Security Group (NSG)
- HTTP inbound rule
- NSG association to subnet

All created **100% from code**.

No Azure Portal clicking.

---
Internet  
↓  
Public Subnet (NSG attached)  
↓  
Private Subnet (isolated)  

### Design Goals

- Separate public & private workloads
- Control inbound traffic using NSGs
- Keep private subnet protected
- Make the setup reproducible across environments

---

## 📁 Project Structure

![folder-structure](https://github.com/CloudByVenkat/terraform-zero-to-hero-with-azure/blob/main/Day%208/images/structure.png)

---

## ⚙️ Key Concepts Practiced

### ✅ Virtual Network
Defines the private IP space for workloads.

### ✅ Subnets
Segment network for:
- public services
- private services

### ✅ Network Security Groups
Acts like a firewall:
- allow/deny traffic
- enforce least privilege

### ✅ Infrastructure as Code
Entire network can be:
- version controlled
- reviewed
- replicated
- destroyed safely

---

## 🔧 Variables

| Name | Purpose | Example |
|--------|-------------|------------|
| project_name | naming prefix | tfz |
| environment | dev/test/prod/stag | stag |
| location | Azure region | eastus |
| vnet_cidr | VNet address space | 10.0.0.0/16 |
| public_subnet_cidr | public subnet | 10.0.1.0/24 |
| private_subnet_cidr | private subnet | 10.0.2.0/24 |

---

## 🗺️ Architecture Overview
![architecture](https://github.com/CloudByVenkat/terraform-zero-to-hero-with-azure/blob/main/Day%208/images/vnet%20daigram.png)
---

## 📌 Part of Series

This repo is part of my public learning journey:

**30 Days of Terraform + Azure**

Follow progress:  
👉 [https://www.linkedin.com/in/cloudbyvenkat/]  
👉 [https://github.com/careerbytecode/terraform-zero-to-hero-with-azure]

---

### ⭐ If this helped you, feel free to fork or star the repo
