#######################################################################
## Create Dev Test Lab
#######################################################################
#resource "azurerm_dev_test_lab" "dtl_demo" {
#  name                = "dtl-demo"
#  location            = var.location
#  resource_group_name = azurerm_resource_group.rg_dev_test_labs.name#
#
#  tags                = var.tags
#}

#######################################################################
## Deploy DTL ARM Template - Important to Set Deployment Mode to Incremental
#######################################################################
resource "azurerm_resource_group_template_deployment" "devtest_lab" {
  count               = 1
  name                = "${var.prefix}dtl-deployment"
  resource_group_name = azurerm_resource_group.rg_dev_test_labs.name

  depends_on = [null_resource.aib_image_build]

  template_content = file("./templates/dtl-deployment.json")

  parameters_content = jsonencode({
    name                    = { value = var.lab_name }
    location                = { value = var.location }
    existingSharedGalleryId = { value = azurerm_shared_image_gallery.sig_set_dev_demo.id }
    existingVNetName        = { value = azurerm_virtual_network.vnet_dev_test_labs.name }
    existingVNetId          = { value = azurerm_virtual_network.vnet_dev_test_labs.id }
    existingSubnetName      = { value = azurerm_subnet.subnet_one.name }
    existingSubnetId        = { value = azurerm_subnet.subnet_one.id }
  })

  deployment_mode = "Incremental"

}