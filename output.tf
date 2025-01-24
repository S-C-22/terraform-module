# outputs.tf
output "vm_id" {
  value = module.vm_s-vm00.vm_id
}

output "vm_public_ip" {
  value = module.vm_s-vm00.vm_public_ip
}
