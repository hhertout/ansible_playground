resource "azurerm_resource_group" "example" {
  name     = var.rg_name
  location = "France Central"
}

resource "azurerm_container_registry" "example" {
  name                = var.container_registry_name
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  sku                 = "Basic"
}
