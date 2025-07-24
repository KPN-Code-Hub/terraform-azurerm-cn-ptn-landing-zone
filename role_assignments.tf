module "role_assignments" {
  source  = "Azure/avm-res-authorization-roleassignment/azurerm"
  version = "0.2.0"

  enable_telemetry = false

  role_assignments_azure_resource_manager = local.role_assignments_resource_manager
  role_assignments_entra_id               = local.role_assignments_entra_id
}
