
module "keyvault" {
  source  = "Azure/avm-res-keyvault-vault/azurerm"
  version = "0.10.1"

  for_each = {
    for key, value in try(local.keyvaults, {}) : key => value
    if value.enabled == true
  }
  
  name                           = "${each.value.name}-${module.keyvault_naming[each.key].key_vault.name_unique}"
  enable_telemetry               = try(each.value.enable_telemetry, false)
  location                       = module.resource_group[each.value.resource_group_key].resource.location
  resource_group_name            = module.resource_group[each.value.resource_group_key].name
  tags                           = local.globals.tags.enabled ? merge(local.globals.tags.object, try(each.value.tags, {})) : try(each.value.tags, {})
  tenant_id                      = try(each.value.tenant_id, data.azurerm_client_config.current.tenant_id)
  public_network_access_enabled  = false
  private_endpoints              = try(each.value.private_endpoints, null)
  legacy_access_policies_enabled = try(each.value.legacy_access_policies_enabled, false)
  legacy_access_policies         = try(each.value.legacy_access_policies_enabled, false) ? try(each.value.legacy_access_policies, null) : null

  diagnostic_settings = try(each.value.diagnostic_settings, null)

  role_assignments = try(each.value.role_assignments, null)

  wait_for_rbac_before_key_operations = try(each.value.wait_for_rbac_before_key_operations, null)

  network_acls = try(each.value.network_acls, null)
}




