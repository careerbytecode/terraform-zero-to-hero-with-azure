# 📘 Day 2 — Infrastructure as Code (IaC) Fundamentals

Today’s focus was understanding **what Infrastructure as Code (IaC)** means, why it matters in cloud engineering, and how Terraform compares to Azure-native IaC tools.

---

## 🧩 What is Infrastructure as Code?

Infrastructure as Code (IaC) means provisioning and managing cloud infrastructure using **code instead of manual clicks** in the Azure Portal.

> “Infrastructure becomes repeatable, version-controlled, and automated — just like software.”

---

## 🎯 Why IaC Matters (Key Benefits)

Three advantages stood out during today’s learning:

1. **Consistency** — predictable deployments across environments  
2. **Speed & Automation** — faster provisioning + reusable code  
3. **Version Control** — infra tracked in Git like application code

Additional benefits include better collaboration, auditing, rollback, CI/CD compatibility, and testing.

---

## 🛠 Azure IaC Tools Comparison

Azure offers multiple infrastructure-as-code options. Each comes with different strengths:

| Tool | Best Use Case | Notes |
|---|---|---|
| **Terraform** | Multi-cloud automation, DevOps pipelines | Most flexible; huge module ecosystem |
| **Bicep** | Azure-native IaC | Simpler and cleaner than ARM |
| **ARM Templates** | Legacy enterprise deployments | JSON-based; still widely used |

If Azure-only, **Bicep** integrates well.  
For multi-cloud or reusable modules, **Terraform** stands out.

---

## 🧪 Environment Check

Environment versions verified today:

```json
cloudbyvenkat@cloudbyvenkat:~/terraform-zero-to-hero$ az version
{
  "azure-cli": "2.82.0",
  "azure-cli-core": "2.82.0",
  "azure-cli-telemetry": "1.1.0",
  "extensions": {}
}
```
```bash
cloudbyvenkat@cloudbyvenkat:~/terraform-zero-to-hero$ az bicep version
Bicep CLI version 0.40.2 (271b0e1d4b)
```
```nginx
cloudbyvenkat@cloudbyvenkat:~/terraform-zero-to-hero$ terraform version
Terraform v1.14.3
on linux_amd64
cloudbyvenkat@cloudbyvenkat:~/terraform-zero-to-hero$
```
