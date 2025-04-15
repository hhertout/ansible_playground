output "labname" {
  value = "Lab infrastructure successfully created ! VM ${azurerm_linux_virtual_machine.vm_1_spot.name} provisioned in ${azurerm_resource_group.rg.name} resource group"
}

output "public_ip_output" {
  value = azurerm_public_ip.example.ip_address
}

output "private_key" {
  value     = azapi_resource_action.ssh_key_pair.output.privateKey
  sensitive = true
}
