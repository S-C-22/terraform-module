# modules/vm/main.tf
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
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "s-vnet" {
  name                = var.virtual_network_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = var.virtual_network_address_space

  depends_on = [ azurerm_resource_group.rg ]
}

resource "azurerm_subnet" "subnets" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.s-vnet.name
  address_prefixes     = var.subnet_address_prefixes

  depends_on = [ azurerm_virtual_network.s-vnet]
}

resource "azurerm_network_interface" "NIC" {
  name                = var.network_interface_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnets.id
    private_ip_address_allocation = "Dynamic"
  }

  depends_on = [ azurerm_subnet.subnets ]
}

resource "azurerm_virtual_machine" "s-vm" {
  name                  = var.vm_name
  resource_group_name   = azurerm_resource_group.rg.name
  location              = azurerm_resource_group.rg.location
  network_interface_ids = [azurerm_network_interface.NIC.id]
  vm_size                  = var.vm_size
  
  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }

  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  delete_os_disk_on_termination = true
  delete_data_disks_on_termination = true

  os_profile {
    computer_name  = var.vm_name
    admin_username = var.admin_username
    admin_password = var.admin_password
  }

  os_profile_windows_config {
    provision_vm_agent = true

    winrm {
    
      protocol = "HTTP"
    }
  }
}
