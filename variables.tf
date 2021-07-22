variable "arm_tenant_id" {
  description = "Tenant ID"
  type        = string
}
variable "arm_subscription_id" {
  description = "Subscrption ID"
  type        = string
}
variable "arm_client_id" {
  description = "Service Principal client id"
  type        = string
}
variable "location" {
  description = "Region"
  type        = string
  default     = "UK South"
}
variable "rg" {
  description = "Resource Group Name"
  type        = string
  default     = "rg-set-dev-demo"
}
variable "prefix" {
  description = "Default Naming Prefix"
  type        = string
  default     = "set-dev-demo"
}
variable "suffix" {
  description = "Default Naming Suffix"
  type        = string
  default     = "set-dev-demo"
}
variable "tags" {
  type        = map(any)
  description = "Tags to be attached to azure resources"
}
variable "username" {
  description = "Username for Virtual Machines"
  type        = string
  default     = "dev-user"
}
variable "password" {
  description = "Virtual Machine password, must meet Azure complexity requirements"
  type        = string
  default     = "Pa55w0rd123!"
}
variable "vmsize" {
  description = "Size of the VMs"
  default     = "Standard_D2_v4"
}
variable "aib_prefix" {
  description = "Prefix for AIB User"
  default     = "satest"
}
variable "sa-name" {
  description = "Name of Storage Account"
  default     = "satest"
}
variable "sa-key" {
  description = "Key of Storage Account"
  default     = ""
  #sensitive   = true
}