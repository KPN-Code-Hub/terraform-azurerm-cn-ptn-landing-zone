# This is the module call
module "containerregistry" {
  source  = "Azure/avm-res-containerregistry-registry/azurerm"
  version = "0.4.0"
  for_each = {
    for key, value in try(local.container_registry, {}) : key => value
    if value.enabled == true
  }

  name                = "${each.value.name}${module.container_registry_naming[each.key].container_registry.name_unique}"
  resource_group_name = try(module.resource_group[each.value.resource_group_key].resource.name, each.value.resource_group_name, null)
  location            = try(module.resource_group[each.value.resource_group_key].resource.location, each.value.location, null)

  admin_enabled                           = try(each.value.admin_enabled, true)
  zone_redundancy_enabled                 = try(each.value.zone_redundancy_enabled, false)
  anonymous_pull_enabled                  = try(each.value.anonymous_pull_enabled, false)
  customer_managed_key                    = try(each.value.customer_managed_key, null)
  data_endpoint_enabled                   = try(each.value.data_endpoint_enabled, false)
  diagnostic_settings                     = try(each.value.diagnostic_settings, {})
  enable_telemetry                        = try(each.value.enable_telemetry, true)
  enable_trust_policy                     = try(each.value.enable_trust_policy, false)
  export_policy_enabled                   = try(each.value.export_policy_enabled, true)
  georeplications                         = try(each.value.georeplications, [])
  lock                                    = try(each.value.lock, null)
  managed_identities                      = try(each.value.managed_identities, {})
  network_rule_bypass_option              = try(each.value.network_rule_bypass_option, null)
  network_rule_set                        = try(each.value.network_rule_set, {})
  private_endpoints                       = try(each.value.private_endpoints, {})
  private_endpoints_manage_dns_zone_group = try(each.value.private_endpoints_manage_dns_zone_group, true)
  public_network_access_enabled           = try(each.value.public_network_access_enabled, true)
  quarantine_policy_enabled               = try(each.value.quarantine_policy_enabled, false)
  retention_policy_in_days                = try(each.value.retention_policy_in_days, 30)
  role_assignments                        = try(each.value.role_assignments, {})
  sku                                     = try(each.value.sku, "Premium")
  tags                                    = try(local.globals.tags.enabled ? merge(local.globals.tags.object, try(each.value.tags, {})) : try(each.value.tags, {}))
}