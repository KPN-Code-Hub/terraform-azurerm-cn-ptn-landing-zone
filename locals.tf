locals {
  resource_groups                   = var.resource_groups
  vnet                              = var.vnet
  snet                              = var.snet
  storage_accounts                  = var.storage_accounts
  aks                               = var.aks
  nsg                               = var.nsg
  keyvaults                         = var.keyvaults
  user_managed_identity             = var.user_managed_identity
  role_assignments_entra_id         = var.role_assignments_entra_id
  role_assignments_resource_manager = var.role_assignments_resource_manager
  globals                           = var.globals
  combined_vnet                     = merge(
    data.azurerm_virtual_network.vnet_read,
    module.vnet
  )
}
