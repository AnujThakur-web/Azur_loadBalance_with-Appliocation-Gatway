data "azurerm_public_ip" "ip" {
  name                = "loadbalancer_ip"
  resource_group_name = "rg-devopsinsiders"
}

resource "azurerm_lb" "lb" {
  name                = "hrsaheb-lb"
  location            = "centralindia"
  resource_group_name = "rg-devopsinsiders"

  frontend_ip_configuration {
    name                 = "NetflixPublicIPAddress"
    public_ip_address_id = data.azurerm_public_ip.ip.id
  }
}

resource "azurerm_lb_backend_address_pool" "pool1" {
  loadbalancer_id = azurerm_lb.lb.id
  name            = "lb-BackEndAddressPool1"
}

resource "azurerm_lb_probe" "probe" {
  loadbalancer_id = azurerm_lb.lb.id
  name            = "netflix-probe"
  port            = 80
}

# IP and Port based Routing
resource "azurerm_lb_rule" "lb_rule" {
  loadbalancer_id                = azurerm_lb.lb.id
  name                           = "NetflixRule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "NetflixPublicIPAddress"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.pool1.id]
  probe_id                       = azurerm_lb_probe.probe.id
}


