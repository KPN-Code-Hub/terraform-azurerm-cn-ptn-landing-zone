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

  admin_enabled                           = each.value.admin_enabled
  anonymous_pull_enabled                  = each.value.anonymous_pull_enabled
  customer_managed_key                    = each.value.customer_managed_key
  data_endpoint_enabled                   = each.value.data_endpoint_enabled
  diagnostic_settings                     = each.value.diagnostic_settings
  enable_telemetry                        = each.value.enable_telemetry
  enable_trust_policy                     = each.value.enable_trust_policy
  export_policy_enabled                   = each.value.export_policy_enabled
  georeplications                         = each.value.georeplications
  lock                                    = each.value.lock
  managed_identities                      = each.value.managed_identities
  network_rule_bypass_option              = each.value.network_rule_bypass_option
  network_rule_set                        = each.value.network_rule_set
  private_endpoints                       = each.value.private_endpoints
  private_endpoints_manage_dns_zone_group = each.value.private_endpoints_manage_dns_zone_group
  public_network_access_enabled           = each.value.public_network_access_enabled
  quarantine_policy_enabled               = each.value.quarantine_policy_enabled
  retention_policy_in_days                = each.value.retention_policy_in_days
  role_assignments                        = each.value.role_assignments
  sku                                     = each.value.sku
  tags                                    = local.globals.tags.enabled ? merge(local.globals.tags.object, try(each.value.tags, {})) : try(each.value.tags, {})
  zone_redundancy_enabled                 = each.value.zone_redundancy_enabled
}

