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
variable "project_name" {
  type = string
}
variable "environment" {
  type = string
}
variable "github_repo_url" {
  type        = string
  description = "GitHub repo URL of your app"
}

variable "app_settings" {
  type    = map(string)
  default = {}
}