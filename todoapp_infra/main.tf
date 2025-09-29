module "virtual_network" {
  source = "../modules/azurerm_virtual_network"

  virtual_network_name     = "vnet-lb"
  virtual_network_location = "centralindia"
  resource_group_name      = "rg-devopsinsiders"
  address_space            = ["10.0.0.0/16"]
  depends_on = [ module.azurerm_resource_group ]
}

module "bastion_subnet" {
  depends_on = [module.virtual_network]
  source     = "../modules/azurerm_subnet"

  resource_group_name  = "rg-devopsinsiders"
  virtual_network_name = "vnet-lb"
  subnet_name          = "AzureBastionSubnet"
  address_prefixes     = ["10.0.2.0/24"]
}

module "public_ip_bastion" {
  source              = "../modules/azurerm_public_ip"
  public_ip_name      = "bastion_ip"
  resource_group_name = "rg-devopsinsiders"
  location            = "centralindia"
  allocation_method   = "Static"
}

module "bastion" {
  source       = "../modules/azurerm_bastion"
  depends_on   = [module.bastion_subnet, module.public_ip_bastion]
  subnet_name  = "AzureBastionSubnet"
  vnet_name    = "vnet-lb"
  rg_name      = "rg-devopsinsiders"
  pip_name     = "bastion_ip"
  bastion_name = "vnet-lb-bastion"
  location     = "centralindia"
}

module "frontend_subnet" {
  depends_on = [module.virtual_network]
  source     = "../modules/azurerm_subnet"

  resource_group_name  = "rg-devopsinsiders"
  virtual_network_name = "vnet-lb"
  subnet_name          = "frontend-subnet"
  address_prefixes     = ["10.0.1.0/24"]
}

module "chinki_vm" {
  source               = "../modules/azurerm_virtual_machine"
  depends_on           = [module.virtual_network, module.frontend_subnet]
  resource_group_name  = "rg-devopsinsiders"
  location             = "centralindia"
  vm_name              = "chinki-vm"
  vm_size              = "Standard_B1s"
  admin_username       = "devopsadmin"
  admin_password       = "P@ssw01rd@123"
  image_publisher      = "Canonical"
  image_offer          = "0001-com-ubuntu-server-focal"
  image_sku            = "20_04-lts"
  image_version        = "latest"
  nic_name             = "nic-chinki-vm"
  vnet_name            = "vnet-lb"
  frontend_subnet_name = "frontend-subnet"
  nsg_name             = "chinki-nsg"
}

module "pinki_vm" {
  source               = "../modules/azurerm_virtual_machine"
  depends_on           = [module.virtual_network, module.frontend_subnet]
  resource_group_name  = "rg-devopsinsiders"
  location             = "centralindia"
  vm_name              = "pinki-vm"
  vm_size              = "Standard_B1s"
  admin_username       = "useradmin"
  admin_password       = "Kr@123456789"
  image_publisher      = "Canonical"
  image_offer          = "0001-com-ubuntu-server-focal"
  image_sku            = "20_04-lts"
  image_version        = "latest"
  nic_name             = "nic-pinki-vm"
  vnet_name            = "vnet-lb"
  frontend_subnet_name = "frontend-subnet"
  nsg_name             = "pinki-nsg"
}

# module "public_ip_lb" {
#   source              = "../modules/azurerm_public_ip"
#   public_ip_name      = "loadbalancer_ip"
#   resource_group_name = "rg-devopsinsiders"
#   location            = "centralindia"
#   allocation_method   = "Static"
# }

# # lb, frontend_ip-config, probe, backend address pool, rule
# module "lb" {
#   depends_on = [module.public_ip_lb]
#   source     = "../modules/azurerm_loadbalancer"
# }

# module "pinki2lb_jod_yojna" {
#   source                = "../modules/azurerm_nic_lb_association"
#   nic_name              = "nic-pinki-vm"
#   resource_group_name   = "rg-devopsinsiders"
#   lb_name               = "hrsaheb-lb"
#   bap_name              = "lb-BackEndAddressPool1"
#   ip_configuration_name = "internal"
# }

# module "chinki2lb_jod_yojna" {
#   source                = "../modules/azurerm_nic_lb_association"
#   nic_name              = "nic-chinki-vm"
#   resource_group_name   = "rg-devopsinsiders"
#   lb_name               = "hrsaheb-lb"
#   bap_name              = "lb-BackEndAddressPool1"
#   ip_configuration_name = "internal"
# }

module "azurerm_resource_group" {
  source = "../modules/azurerm_resource_group"
  resource_group_name = "rg-devopsinsiders"
  resource_group_location = "centralindia"
}