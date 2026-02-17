# 🚀 Day 15 – Designing Scalable Infrastructure with for_each

## 🎯 Objective
Eliminate repetition in Terraform and design infrastructure that scales automatically.

## 🧠 Architectural Thinking
Instead of defining multiple resources manually, I implemented `for_each` to dynamically create subnets.

This ensures:
- Scalability
- Cleaner code
- Easier maintenance
- Reduced duplication risk

## 🏗 What Was Implemented
- Azure Virtual Network
- Multiple subnets created dynamically using `for_each`
- Structured map-based configuration

## 💡 Why This Matters
In enterprise environments, infrastructure must scale without rewriting code.
Dynamic provisioning ensures consistency across growth scenarios.

## 🔍 Key Concept
```hcl
for_each = local.subnets
