#   Terraform variables for Azure infrastructure deployment and configuration. Update the values with your specific Azure credentials and settings.
subscription_id    = " " # Updae with your Azure Subscription ID
client_id          = " " # Update with your Azure Client ID
client_secret      = " " # Update with your Azure Client Secret
tenant_id          = " " # Update with your Azure Tenant ID
location           = "canadacentral"
admin_password     = "  " # Update with a strong password for the VM admin user
suffix             = "day11"
project_name       = "tfhero"
environment        = "dev"
vnet_cidr          = "10.0.0.0/16"
public_subnet_cidr = "10.0.1.0/24"