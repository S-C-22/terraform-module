# main.tf
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.1.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "dcbf64cd-cdc5-4a9f-badb-49d6df1bb14d"
}


module "vm_s-vm00" {
  source                  = "./module/VM"
  
}

output "vm_id" {
  value = module.vm_example.vm_id
}

output "vm_public_ip" {
  value = module.vm_example.vm_public_ip
}