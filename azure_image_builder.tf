#######################################################################
## Create Image using Azure Image Builder; not yet supported in TF
#######################################################################
## Update AIB JSON Config with Managed Identity
#######################################################################
resource "null_resource" "aib_image_json_interpolation" {
  
  depends_on = [
    azurerm_shared_image_gallery.sig_set_dev_demo
  ]

  provisioner "local-exec" {

    # get the user identity URI, needed for the template
    #command = "imgBuilderId=/subscriptions/${var.arm_subscription_id}/resourcegroups/${azurerm_resource_group.rg_dev_test_labs.name}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/${azurerm_user_assigned_identity.dtl_mi.name}"

  command = "varName2=/subscriptions/${var.arm_subscription_id}/resourcegroups/${azurerm_resource_group.rg_dev_test_labs.name}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/${azurerm_user_assigned_identity.dtl_mi.name} ; sed -i -e \"s%<imgBuilderId>%$varName2%g\" Custom_Windows_Dev_Shared_Image.json"
  }
}
#######################################################################
## Create Image Template
#######################################################################
resource "null_resource" "aib_image_definition" {
  
  depends_on = [
    null_resource.aib_image_json_interpolation
  ]

  provisioner "local-exec" {

  command = "az resource create --resource-group ${azurerm_resource_group.rg_dev_test_labs.name} --properties @Custom_Windows_Dev_Shared_Image.json --is-full-object --resource-type Microsoft.VirtualMachineImages/imageTemplates  -n dtlWinDevDemo"
  }
}
#######################################################################
## Create Image
#######################################################################
resource "null_resource" "aib_image_build" {
  
  depends_on = [
    null_resource.aib_image_definition
  ]

  provisioner "local-exec" {

  command = "az resource invoke-action --resource-group ${azurerm_resource_group.rg_dev_test_labs.name} --resource-type  Microsoft.VirtualMachineImages/imageTemplates -n dtlWinDevDemo --action Run"
  }
}