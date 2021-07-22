#######################################################################
## Create Resource Group for Resources
#######################################################################
resource "azurerm_resource_group" "rg_dev_test_labs" {
  name     = "rg-${var.suffix}"
  location = var.location
  tags     = var.tags
}

#######################################################################
## Create Single vNET with two Subnets
#######################################################################
resource "azurerm_virtual_network" "vnet_dev_test_labs" {
  name                = "vnet-${var.suffix}"
  resource_group_name = azurerm_resource_group.rg_dev_test_labs.name
  location            = var.location
  address_space       = ["10.0.0.0/16"]
  tags                = var.tags
}

#######################################################################
## Create a Bastion Subnet just in case
#######################################################################
resource "azurerm_subnet" "bastion_subnet" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.rg_dev_test_labs.name
  virtual_network_name = azurerm_virtual_network.vnet_dev_test_labs.name
  address_prefixes     = ["10.0.0.0/24"]
}

resource "azurerm_subnet" "subnet_one" {
  name                 = "subnet-one"
  resource_group_name  = azurerm_resource_group.rg_dev_test_labs.name
  virtual_network_name = azurerm_virtual_network.vnet_dev_test_labs.name
  address_prefixes     = ["10.0.1.0/24"]
}

#######################################################################
## Create Bastion in Hub
#######################################################################
resource "azurerm_public_ip" "bastion_pip" {
  name                = "${var.prefix}-bastion"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg_dev_test_labs.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_bastion_host" "bastion" {
  name                = "bastion"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg_dev_test_labs.name

  ip_configuration {
    name                 = "bastion-configuration"
    subnet_id            = azurerm_subnet.bastion_subnet.id
    public_ip_address_id = azurerm_public_ip.bastion_pip.id
  }
}