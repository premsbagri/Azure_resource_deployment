rgs = {
  rg1 = {
    rg_name  = "rg-dev"
    location = "Australia East"
  }
}

vnets = {
  vnets1 = {
    vnet_name           = "vnet-dev"
    location            = "Australia East"
    resource_group_name = "rg-dev"
    address_space       = ["10.0.0.0/16"]
  }
}

subnets = {
  subnets1 = {
    subnet_name          = "subnet-dev"
    resource_group_name  = "rg-dev"
    virtual_network_name = "vnet-dev"
    address_prefixes     = ["10.0.0.0/24"]
  }
}

pips = {
  pips1 = {
    pip_name            = "pip-dev"
    location            = "Australia East"
    resource_group_name = "rg-dev"
  }
}

nics = {
  nics1 = {
    nic_name            = "nic-dev"
    location            = "Australia East"
    resource_group_name = "rg-dev"
  }
}

vms = {
  vms1 = {
    vm_name        = "linuxvm-dev"
    rg_name        = "rg-dev"
    location       = "Australia East"
    size           = "Standard_D2s_v6"
    admin_username = "premvm"
    admin_password = "prem@123"
  }
}



