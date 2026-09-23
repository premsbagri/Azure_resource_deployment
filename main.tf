resource "azurerm_resource_group" "rg" {
  for_each = var.rgs
  name     = each.value.rg_name
  location = each.value.location
}

resource "azurerm_virtual_network" "vnet" {
  for_each            = var.vnets
  name                = each.value.vnet_name
  location            = each.value.location
 resource_group_name = azurerm_resource_group.rg["rg1"].name
  address_space       = each.value.address_space
}

resource "azurerm_subnet" "sbnet" {
  for_each             = var.subnets
  name                 = each.value.subnet_name
resource_group_name = azurerm_resource_group.rg["rg1"].name
  virtual_network_name = azurerm_virtual_network.vnet["vnets1"].name
  address_prefixes     = each.value.address_prefixes
}

resource "azurerm_public_ip" "pip" {
  for_each            = var.pips
  name                = each.value.pip_name
  location            = each.value.location
  resource_group_name = azurerm_resource_group.rg["rg1"].name
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "nic" {
  for_each            = var.nics
  name                = each.value.nic_name
  location            = each.value.location
  resource_group_name = azurerm_resource_group.rg["rg1"].name

  ip_configuration {
    name                          = "internalip"
    subnet_id                     = azurerm_subnet.sbnet["subnets1"].id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "linuxvm" {
  for_each                        = var.vms
  name                            = each.value.vm_name
  resource_group_name             = each.value.rg_name
  location                        = each.value.location
  size                            = each.value.size
  admin_username                  = each.value.admin_username
  admin_password                  = each.value.admin_password
  disable_password_authentication = false

  network_interface_ids = [
    azurerm_network_interface.nic["nics1"].id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
}