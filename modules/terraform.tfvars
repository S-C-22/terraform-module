#terraform.tfvars 
resource_group_name     = "Soumili"
location                = "East US"
virtual_network_name    = "sc-VNet"
virtual_network_address_space = ["10.0.0.0/16"]
subnet_name             = "Subnet-1"
subnet_address_prefixes = ["10.0.1.0/24"]
network_interface_name  = "myNIC"
vm_name                 = "VM-1"
vm_size                 = "Standard_DS1_v2"
admin_username          = "SC"
admin_password          = "soumili@123456"