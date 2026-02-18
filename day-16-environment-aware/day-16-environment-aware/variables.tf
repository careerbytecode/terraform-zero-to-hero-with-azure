variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "envaware"
}

variable "environment" {
  description = "Environment name (dev, stag, prod)"
  type        = string

  validation {
    condition     = contains(["dev", "stag", "prod"], var.environment)
    error_message = "Environment must be dev, stag, or prod."
  }
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "canadacentral"
}

variable "sql_admin_username" {
  description = "SQL Server administrator username"
  type        = string
  default     = "sqladmin"
  sensitive   = true
}

variable "sql_admin_password" {
  description = "SQL Server administrator password"
  type        = string
  sensitive   = true
}

variable "aad_admin_login" {
  description = "Azure AD admin login (required for production)"
  type        = string
  default     = null
}

variable "aad_admin_object_id" {
  description = "Azure AD admin object ID (required for production)"
  type        = string
  default     = null
}
# variable "client_secret" {
#   type      = string
#   sensitive = true
# }
# variable "tenant_id" {
#   type = string

# }
# variable "client_id" {
#   type = string
# }
# variable "subscription_id" {
#   type = string
# }