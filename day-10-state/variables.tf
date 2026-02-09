variable "project_name" {
  type = string
}
variable "environment" {
  type = string
}
variable "suffix" {
  type = string
}

variable "admin_password" {
  type      = string
  sensitive = true
}
variable "location" {
  type = string
}
variable "vnet_cidr" {
  type    = string
  default = "10.0.0.0/16"
}
variable "public_subnet_cidr" {
  type    = string
  default = "10.0.1.0/24"
}
variable "private_subnet_cidr" {
  type    = string
  default = "10.0.2.0/24"
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
