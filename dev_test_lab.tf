#######################################################################
## Create Dev Test Lab
#######################################################################
resource "azurerm_dev_test_lab" "dtl_demo" {
  name                = "dtl-demo"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg_dev_test_labs.name

  tags                = var.tags
}