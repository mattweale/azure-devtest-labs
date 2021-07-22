#######################################################################
## Outputs
#######################################################################
output "user_assigned_identity" {
  value       = azurerm_user_assigned_identity.dtl_mi.name
  description = "The name of the managed identity"
}

output "storage_account_key" {
  value       = azurerm_storage_account.sa_dtl.primary_access_key
  description = "Storage Accoun Access Key"
  sensitive   = true
  }