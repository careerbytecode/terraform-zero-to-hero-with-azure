# 🚀 Day 17 — Secure by Design (Azure Key Vault Integration)

## 🎯 Objective

Design infrastructure with security embedded from the beginning —  
by removing hardcoded secrets and implementing centralized secret management using Azure Key Vault.

This marks the transition from "working infrastructure"  
to "secure architecture".

---

## 🧠 Architectural Problem

In many projects:

- Passwords are stored in Terraform variables
- Secrets are committed in repositories
- Credentials are passed as plain text
- Security is treated as an afterthought

This creates:

- Audit risks
- Compliance violations
- Exposure to breaches
- Operational vulnerabilities

So the real question becomes:

> How do we design infrastructure that protects secrets by default?

---

## 🏗 Architectural Solution

Integrate Azure Key Vault with Terraform  
and remove secrets from infrastructure logic.

Design principles applied:

- Centralized secret storage
- Managed identity authentication
- Least privilege access
- Separation of concerns

---

## 🔐 Implementation Overview

### 1️⃣ Retrieve Tenant Information

```hcl
data "azurerm_client_config" "current" {}
```

---

### 2️⃣ Create Azure Key Vault

```hcl
resource "azurerm_key_vault" "kv" {
  name                        = "kv-${var.project_name}"
  location                    = var.location
  resource_group_name         = azurerm_resource_group.rg.name
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name                    = "standard"
  purge_protection_enabled    = false
}
```

---

### 3️⃣ Store Secret Securely

```hcl
resource "azurerm_key_vault_secret" "sql_password" {
  name         = "sql-password"
  value        = var.sql_admin_password
  key_vault_id = azurerm_key_vault.kv.id
}
```

---

### 4️⃣ Enable Managed Identity in App Service

```hcl
identity {
  type = "SystemAssigned"
}
```

---

## 🏗 What This Enables

✔ No hardcoded secrets  
✔ Secure secret storage  
✔ Centralized credential management  
✔ Enterprise security posture  
✔ Audit-friendly infrastructure  

---

## 💼 Business Impact

Security-first design provides:

- Reduced breach risk
- Compliance readiness
- Improved audit posture
- Better governance alignment
- Long-term maintainability

In enterprise cloud environments, security is not optional —  
it is foundational.

---

## 📌 Key Architectural Principle

Infrastructure should assume:

- Code repositories may be exposed
- Teams will scale
- Compliance audits will occur
- Secrets must rotate

If credentials exist inside code — security is already compromised.

---

## 🧪 How to Validate

After deployment:

1. Verify Key Vault is created.
2. Confirm secret exists inside Key Vault.
3. Confirm App Service has Managed Identity enabled.
4. Ensure no plain-text secrets exist in Terraform output.

---

## 🏁 Lesson Learned

Security is not a configuration step.

It is an architectural decision.

Designing secure infrastructure from day one  
reduces future technical debt and operational risk.

---
