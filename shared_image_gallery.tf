#######################################################################
## Create Shared Image Gallery
#######################################################################
resource "azurerm_shared_image_gallery" "sig_set_dev_demo" {
  name                = "setSIG"
  resource_group_name = azurerm_resource_group.rg_dev_test_labs.name
  location            = var.location
  description         = "SET Developer Environment Demo SIG"

  tags = var.tags
}

#######################################################################
## Create Image Defintion in SIG
#######################################################################
resource "azurerm_shared_image" "image_sig_set_dev_demo" {
  name                = "win10DevDesktop"
  gallery_name        = azurerm_shared_image_gallery.sig_set_dev_demo.name
  resource_group_name = azurerm_resource_group.rg_dev_test_labs.name
  location            = var.location
  os_type             = "Windows"

  identifier {
    publisher = "MattW"
    offer     = "Windows10"
    sku       = "AWEWin10DevDesktop"
  }
}