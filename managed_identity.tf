#######################################################################
## Create User Assigned Identity for Image Builder
#######################################################################
## First create random uuid
#######################################################################
resource "random_uuid" "mi_uid" {
}

#######################################################################
## Create MI
#######################################################################
resource "azurerm_user_assigned_identity" "dtl_mi" {
  resource_group_name = azurerm_resource_group.rg_dev_test_labs.name
  location            = var.location
  name = "aibBuiUserId-${random_uuid.mi_uid.result}"
}

#######################################################################
## Give MI Contributor Role to RG
#######################################################################
resource "azurerm_role_assignment" "ra_aib_mi" {
  scope                = azurerm_resource_group.rg_dev_test_labs.id
  role_definition_name = "Contributor"
  principal_id         = azurerm_user_assigned_identity.dtl_mi.principal_id
  }
