output "app_url" {
  value = "https://${azurerm_windows_web_app.app.default_hostname}"
}