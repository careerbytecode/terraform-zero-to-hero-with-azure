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
variable "location" {
  type = string
}
variable "admin_password" {
  type      = string
  sensitive = true
}
variable "suffix" {
  type = string
}
variable "project_name" {
  type = string
}
variable "environment" {
  type = string
}
variable "vnet_cidr" {
  type = string

}
variable "public_subnet_cidr" {
  type = string
}