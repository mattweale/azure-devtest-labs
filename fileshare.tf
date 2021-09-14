#######################################################################
## Create Storage Account
#######################################################################
resource "azurerm_storage_account" "sa_dtl" {
  name                     = "sadtldemofs"
  resource_group_name      = azurerm_resource_group.rg_dev_test_labs.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  #account_kind              = "StorageV2"
  access_tier               = "hot"
  enable_https_traffic_only = true
  min_tls_version           = "TLS1_2"
  allow_blob_public_access  = false

  tags                     = var.tags
}

#######################################################################
## Create the File Share
#######################################################################
resource "azurerm_storage_share" "share_dtl" {
  name                 = "demo-share"
  storage_account_name = azurerm_storage_account.sa_dtl.name
  quota                = 50
}