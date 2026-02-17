variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "scalable"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "location" {
  description = "Primary Azure region"
  type        = string
  default     = "East US"
}

variable "backup_location" {
  description = "Backup Azure region"
  type        = string
  default     = "West US"
}

variable "client_secret" {
  type      = string
  sensitive = true
}
variable "tenant_id" {
  type = string

}
variable "client_id" {
  type = string
}
variable "subscription_id" {
  type = string
}
