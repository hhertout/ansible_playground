resource "azurerm_resource_group" "rg" {
  name     = var.rg_name
  location = "France Central"
}


resource "azurerm_postgresql_flexible_server" "pg" {
  name                = "az-pg-flexible-server"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  version             = "16"

  administrator_login    = var.db_username
  administrator_password = var.db_password

  sku_name     = "B_Standard_B1ms"
  storage_tier = "P4"

  storage_mb = 32768
}

resource "azurerm_postgresql_flexible_server_database" "db" {
  name      = var.db_name
  server_id = azurerm_postgresql_flexible_server.pg.id
  collation = "en_US.utf8"
  charset   = "UTF8"


  lifecycle {
    prevent_destroy = true
  }
}
