# modules/vm/outputs.tf

output "vm_id" {
  description = "The ID of the created VM"
  value       = azurerm_virtual_machine.s-vm.id
}

output "vm_public_ip" {
  description = "The public IP address of the VM"
  value       = azurerm_network_interface.NIC.ip_configuration[0].private_ip_address
}
