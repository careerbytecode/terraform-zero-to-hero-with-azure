# 🌍 Day 3 — Terraform Workflow + First Resource Deployment

Today’s objective was to understand and test the basic Terraform workflow:
**init → validate  →  plan → apply → destroy**, as well as HCL syntax basics.

---

## 🧩 Terraform Workflow Overview

Terraform follows a predictable lifecycle:

**What each step does:**

| Command | Purpose |
|---|---|
| `terraform init` | Downloads provider plugins + initializes working directory |
| `terraform validate` | Validate the syntax is correct or not |
| `terraform plan` | Shows a preview of changes (dry run) |
| `terraform apply` | Executes changes against Azure |
| `terraform destroy` | Removes resources created by Terraform |

![terraform_workflow](https://github.com/CloudByVenkat/terraform-zero-to-hero-with-azure/blob/main/images/terraform_workflow.png)
---

## 💻 First Terraform Resource ("Hello World")
### 1️⃣ Log in Azure by running below command in visual studio

```bash
cloudbyvenkat@cloudbyvenkat:~/terraform-zero-to-hero$ az login --use-device-code
To sign in, use a web browser to open the page https://microsoft.com/devicelogin and enter the code DBWS6ZLRJ to authenticate.
```
### 2️⃣ Open the chrome browser and enther above link
Copy and Paste the Code:
![browser](https://github.com/CloudByVenkat/terraform-zero-to-hero-with-azure/blob/main/images/az-log-in-1.png)

Click or Enter your azure email ID and password:
![authenicate](https://github.com/CloudByVenkat/terraform-zero-to-hero-with-azure/blob/main/images/az-log-in-2.png)
Below image confirm:
![authenicate](https://github.com/CloudByVenkat/terraform-zero-to-hero-with-azure/blob/main/images/az-log-in-3.png)

### 3️⃣ Select the Subscription 
```bash
cloudbyvenkat@cloudbyvenkat:~/terraform-zero-to-hero$ az login --use-device-code
To sign in, use a web browser to open the page https://microsoft.com/devicelogin and enter the code DBWS6ZLRJ to authenticate.

Retrieving tenants and subscriptions for the selection...

[Tenant and subscription selection]

No     Subscription name    Subscription ID                       Tenant
-----  -------------------  ------------------------------------  -------------
[1]    Application          437fa1e1-82de-4517-85a2-f79564455521  CloudByVenkat
[2]    Connectivity         df837262-1161-4d4e-b3ac-1a24a60a6e46  CloudByVenkat
[3]    Identity             ac9b5709-e031-4931-b247-7058eee789ff  CloudByVenkat
[4]    Management           dbd81b0e-7078-4a33-8d32-93b999d95704  CloudByVenkat
[5] *  Platform             19644874-3e1c-4f4a-8d5f-2901769bf6a7  CloudByVenkat

The default is marked with an *; the default tenant is 'CloudByVenkat' and subscription is 'Platform' (19644874-3e1c-4f4a-8d5f-2901769bf6a7).

Select a subscription and tenant (Type a number or Enter for no changes):
```
### 4️⃣ Create a simple Resource Group using Terraform:
```json
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.58.0"
    }
  }
}
provider "azurerm" {
  subscription_id = "19644874-3e1c-4f4a-8d5f-2901769bf6a7"
  features {}
}
resource "azurerm_resource_group" "rg_storage_stag_eastus_001" {
  name     = "rg-storage-stag-eastus-001"
  location = "eastus"
}
```
You get error while running terraform plan if not able to choose default subscription, run below command 
```bash
export ARM_SUBSCRIPTION_ID="19644874-3e1c-4f4a-8d5f-2901769bf6a7"
```
Initialization:
```bash
cloudbyvenkat@cloudbyvenkat:~/terraform-zero-to-hero/DAY3$ terraform init
Initializing the backend...
Initializing provider plugins...
- Finding hashicorp/azurerm versions matching "4.58.0"...
- Installing hashicorp/azurerm v4.58.0...
- Installed hashicorp/azurerm v4.58.0 (signed by HashiCorp)
Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
cloudbyvenkat@cloudbyvenkat:~/terraform-zero-to-hero/DAY3$
```
Validate Syntax:
```bash
cloudbyvenkat@cloudbyvenkat:~/terraform-zero-to-hero/DAY3$ terraform validate
Success! The configuration is valid.

cloudbyvenkat@cloudbyvenkat:~/terraform-zero-to-hero/DAY3$
```
Preview (dry run):
```bash
cloudbyvenkat@cloudbyvenkat:~/terraform-zero-to-hero/DAY3$ terraform plan -out main.tfplan

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # azurerm_resource_group.rg_storage_stag_eastus_001 will be created
  + resource "azurerm_resource_group" "rg_storage_stag_eastus_001" {
      + id       = (known after apply)
      + location = "eastus"
      + name     = "rg-storage-stag-eastus-001"
    }

Plan: 1 to add, 0 to change, 0 to destroy.

─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Saved the plan to: main.tfplan

To perform exactly these actions, run the following command to apply:
    terraform apply "main.tfplan"
cloudbyvenkat@cloudbyvenkat:~/terraform-zero-to-hero/DAY3$
```
Apply deployment:
```bash
cloudbyvenkat@cloudbyvenkat:~/terraform-zero-to-hero/DAY3$ terraform apply main.tfplan
azurerm_resource_group.rg_storage_stag_eastus_001: Creating...
azurerm_resource_group.rg_storage_stag_eastus_001: Still creating... [00m10s elapsed]
azurerm_resource_group.rg_storage_stag_eastus_001: Still creating... [00m20s elapsed]
azurerm_resource_group.rg_storage_stag_eastus_001: Creation complete after 27s [id=/subscriptions/19644874-3e1c-4f4a-8d5f-2901769bf6a7/resourceGroups/rg-storage-stag-eastus-001]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
cloudbyvenkat@cloudbyvenkat:~/terraform-zero-to-hero/DAY3$
```

After deployment:
```bash
cloudbyvenkat@cloudbyvenkat:~/terraform-zero-to-hero/DAY3$ az group list --output table
```
Expected output: CLI
```bash
Name                        Location       Status
--------------------------  -------------  ---------
rg-storage-stag-eastus-001  eastus         Succeeded

cloudbyvenkat@cloudbyvenkat:~/terraform-zero-to-hero/DAY3$
```
Expected output: Azure Portal
![rg](https://github.com/careerbytecode/terraform-zero-to-hero-with-azure/blob/main/images/rg.png)
Cleanup:
```json
cloudbyvenkat@cloudbyvenkat:~/terraform-zero-to-hero/DAY3$ terraform destroy
azurerm_resource_group.rg_storage_stag_eastus_001: Refreshing state... [id=/subscriptions/19644874-3e1c-4f4a-8d5f-2901769bf6a7/resourceGroups/rg-storage-stag-eastus-001]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  - destroy

Terraform will perform the following actions:

  # azurerm_resource_group.rg_storage_stag_eastus_001 will be destroyed
  - resource "azurerm_resource_group" "rg_storage_stag_eastus_001" {
      - id         = "/subscriptions/19644874-3e1c-4f4a-8d5f-2901769bf6a7/resourceGroups/rg-storage-stag-eastus-001" -> null
      - location   = "eastus" -> null
      - name       = "rg-storage-stag-eastus-001" -> null
      - tags       = {} -> null
        # (1 unchanged attribute hidden)
    }

Plan: 0 to add, 0 to change, 1 to destroy.

Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: 

cloudbyvenkat@cloudbyvenkat:~/terraform-zero-to-hero/DAY3$ 
```
Enter the value as yes
```bash
azurerm_resource_group.rg_storage_stag_eastus_001: Destroying... [id=/subscriptions/19644874-3e1c-4f4a-8d5f-2901769bf6a7/resourceGroups/rg-storage-stag-eastus-001]
azurerm_resource_group.rg_storage_stag_eastus_001: Still destroying... [id=/subscriptions/19644874-3e1c-4f4a-8d5f-...ourceGroups/rg-storage-stag-eastus-001, 00m10s elapsed]
azurerm_resource_group.rg_storage_stag_eastus_001: Still destroying... [id=/subscriptions/19644874-3e1c-4f4a-8d5f-...ourceGroups/rg-storage-stag-eastus-001, 00m20s elapsed]
azurerm_resource_group.rg_storage_stag_eastus_001: Destruction complete after 23s

Destroy complete! Resources: 1 destroyed.
```
