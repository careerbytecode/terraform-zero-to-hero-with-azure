variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "secure"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "stag", "prod"], var.environment)
    error_message = "Environment must be dev, stag, or prod."
  }
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "Canada Central"
}

variable "sql_admin_username" {
  description = "SQL Server administrator username (password generated automatically)"
  type        = string
  default     = "sqladmin"
  sensitive   = true
}