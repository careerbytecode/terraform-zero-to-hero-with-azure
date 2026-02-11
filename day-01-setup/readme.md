# 📘 Day 1 — Terraform on Azure: Environment Setup (Ubuntu)

Welcome to **Day 1** of the **30-Day Terraform on Azure Challenge**!

Today we will install and verify:

- Terraform
- Azure CLI
- Visual Studio Code

This guide is optimized for **Ubuntu 20.04+** and is designed to be **copy → paste → run**.

---

## 🧰 Prerequisites

- Ubuntu (local, WSL, cloud VM or container)
- Sudo permissions
- Internet access

---

## 1️⃣ Update System

```bash
sudo apt update && sudo apt upgrade -y
```
Output:
```nginx
cloudbyvenkat@cloudbyvenkat:~/terraform-zero-to-hero$ sudo apt update && sudo apt upgrade -y
Hit:1 http://archive.ubuntu.com/ubuntu noble InRelease
Hit:2 http://archive.ubuntu.com/ubuntu noble-updates InRelease                                                                             
Hit:3 http://archive.ubuntu.com/ubuntu noble-backports InRelease                                                                           
Hit:4 https://apt.releases.hashicorp.com noble InRelease                                                                                   
Hit:5 https://packages.microsoft.com/repos/azure-cli noble InRelease                                                                       
Hit:6 https://packages.microsoft.com/repos/microsoft-ubuntu-noble-prod noble InRelease
Hit:7 http://security.ubuntu.com/ubuntu noble-security InRelease           
Reading package lists... Done                        
Building dependency tree... Done
Reading state information... Done
All packages are up to date.
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
Calculating upgrade... Done
The following package was automatically installed and is no longer required:
  libllvm19
Use 'sudo apt autoremove' to remove it.
0 upgraded, 0 newly installed, 0 to remove and 0 not upgraded.
cloudbyvenkat@cloudbyvenkat:~/terraform-zero-to-hero$
```
## 2️⃣ Install Terraform (Official HashiCorp Repo)

```bash
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common

wget -O- https://apt.releases.hashicorp.com/gpg | \
  gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg >/dev/null

echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \

https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
  sudo tee /etc/apt/sources.list.d/hashicorp.list

sudo apt-get update
sudo apt-get install terraform -y
```
✔ Verify Terraform

```bash
terraform -version
```
Output:
```nginx
cloudbyvenkat@cloudbyvenkat:~/terraform-zero-to-hero$ terraform -version
Terraform v1.14.3
on linux_amd64
cloudbyvenkat@cloudbyvenkat:~/terraform-zero-to-hero$
```
## 3️⃣ Install Azure CLI (Microsoft Official Repo)

```bash
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
```
✔ Verify Azure CLI

```bash
az version
```
```json
cloudbyvenkat@cloudbyvenkat:~/terraform-zero-to-hero$ az version
{
  "azure-cli": "2.82.0",
  "azure-cli-core": "2.82.0",
  "azure-cli-telemetry": "1.1.0",
  "extensions": {}
}
cloudbyvenkat@cloudbyvenkat:~/terraform-zero-to-hero$
```
Login to Azure (required for future days):
```bash
az login
```
## 4️⃣ Install Visual Studio Code
```bash
sudo apt update
sudo apt install wget gpg -y

wget -O- https://packages.microsoft.com/keys/microsoft.asc | \
  gpg --dearmor | sudo tee /usr/share/keyrings/microsoft.gpg >/dev/null

echo "deb [arch=$(dpkg --print-architecture)] \
signed-by=/usr/share/keyrings/microsoft.gpg \
https://packages.microsoft.com/repos/code stable main" | \
  sudo tee /etc/apt/sources.list.d/vscode.list

sudo apt update
sudo apt install code -y
```
✔ Launch VS Code
```bash
code
```
## 5️⃣ Recommended VS Code Extensions (Optional but Useful)
```bash
code --install-extension hashicorp.terraform
code --install-extension ms-azuretools.vscode-azureresourcegroups
code --install-extension ms-azuretools.vscode-azureterraform
```
## 6️⃣ Final Verification Step

Run this to confirm everything installed correctly:
```bash
terraform -version && az version
```
Output:
![terraform & Azure version output](https://github.com/CloudByVenkat/terraform-zero-to-hero-with-azure/blob/main/images/terraform-azure-version.png)

If you see both outputs → 🎉 You're ready for Day 2!
