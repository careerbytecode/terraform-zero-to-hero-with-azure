# 🚀 Day 16 — Intelligent Infrastructure with Conditional Expressions
## [Cost Comparision - Click Here](https://cloudbyvenkat.github.io/terraform-zero-to-hero-with-azure/day-16-environment-aware/index.html)
## 🎯 Objective

Design environment-aware infrastructure using Terraform conditionals —  
so the same codebase adapts automatically across Dev and Production.
This is where Terraform moves from static provisioning  
to intelligent system design.

---

## 🧠 Architectural Problem

In real enterprise environments:

- Dev requires lower cost infrastructure
- Production requires higher performance
- Maintaining separate Terraform projects increases risk
- Duplicated code leads to configuration drift

So the question becomes:

> How do we maintain one codebase but allow different behaviors?

---

## 🏗 Architectural Solution

Use Terraform conditional expressions and workspace-based logic.

Instead of duplicating infrastructure,  
we make infrastructure adapt.

---

## 🔍 Implementation Overview

### 1️⃣ Detect Environment

```hcl
locals {
  environment = terraform.workspace
}
```

---

### 2️⃣ Apply Conditional Logic

```hcl
locals {
  sql_sku = local.environment == "prod" ? "S0" : "Basic"
}
```

---

### 3️⃣ Use Conditional SKU in Resource

```hcl
resource "azurerm_mssql_database" "db" {
  name      = "appdb"
  server_id = azurerm_mssql_server.sql.id
  sku_name  = local.sql_sku
}
```

---

## 🏗 Infrastructure Behavior

| Environment | SQL SKU |
|------------|----------|
| dev        | Basic    |
| prod       | S0       |

Same code.  
Different behavior.  
Zero duplication.

---

## 💼 Business Impact

This approach enables:

- 💰 Cost optimization in lower environments
- ⚡ Performance scaling in production
- 📦 Single source of truth
- 🔄 Easier maintenance
- 🚫 Reduced deployment errors

Enterprise cloud environments must balance cost and performance intelligently.

---

## 📌 Why This Matters

Infrastructure should:

- Adapt to context
- Avoid duplication
- Remain scalable
- Be maintainable long term

Conditionals allow infrastructure to become dynamic — not static.

---

## 🧪 How to Test

```bash
terraform workspace new dev
terraform apply

terraform workspace new prod
terraform apply
```

Observe different SKUs deployed based on workspace.

---

## 🏁 Key Lesson

Good infrastructure works.

Great infrastructure adapts.

Terraform conditionals enable intelligent architecture decisions  
directly inside Infrastructure as Code.

---
