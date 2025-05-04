resource "azurerm_resource_group" "rg" {
  name     = var.rg_name
  location = "West Europe"
}

resource "azurerm_service_plan" "default" {
  name                = "ASP-${azurerm_resource_group.rg.location}-85c"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  os_type             = "Linux"
  sku_name            = "B1"
}


resource "azurerm_linux_web_app" "default" {
  name                                     = var.app_name
  resource_group_name                      = azurerm_resource_group.rg.name
  location                                 = azurerm_service_plan.default.location
  service_plan_id                          = azurerm_service_plan.default.id
  https_only                               = var.app_https_only
  ftp_publish_basic_authentication_enabled = false

  depends_on = [
    azurerm_service_plan.default
  ]

  site_config {
    container_registry_use_managed_identity = var.docker_private_repository

    application_stack {
      docker_image_name        = var.docker_image_name
      docker_registry_url      = var.docker_registry_url
      docker_registry_username = var.docker_private_repository ? var.docker_registry_creds.username : null
      docker_registry_password = var.docker_private_repository ? var.docker_registry_creds.password : null
    }

    always_on = false
  }

  app_settings = {
    WEBSITES_PORT    = 8000
    DOCKER_ENABLE_CI = var.enable_ci
  }

  tags = var.tags
}
