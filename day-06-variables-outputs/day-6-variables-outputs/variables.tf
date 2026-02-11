variable "location" {
  type    = string
}
variable "environment" {
  type    = string
}
variable "resource_group_name" {
  type    = string
}
variable "storage_account_name" {
  type    = string
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
