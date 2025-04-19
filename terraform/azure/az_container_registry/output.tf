output "name" {
  description = "Name of the container registry"
  value       = azurerm_container_registry.example.name
}

output "login_server" {
  description = "Login server of the container registry"
  value       = azurerm_container_registry.example.login_server
}

output "admin_user" {
  description = "Admin user for the container registry"
  value       = azurerm_container_registry.example.admin_username
}

output "admin_password" {
  description = "Admin password for the container registry"
  value       = azurerm_container_registry.example.admin_password
  sensitive   = true
}
