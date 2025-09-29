data "azurerm_subnet" "frontend_subnet" {
  name                 = var.frontend_subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.resource_group_name
}
