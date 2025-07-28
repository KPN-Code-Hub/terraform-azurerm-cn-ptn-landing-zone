module "aks_automatic" {
  source  = "Azure/avm-res-containerservice-managedcluster/azurerm"
  version = "0.2.5"

  for_each = {
    for key, value in try(local.aks, {}) : key => value
    if value.enabled == true
  }

  enable_telemetry = try(each.value.enable_telemetry, false)

  default_node_pool = try(each.value.default_node_pool, {})

  location                                         = module.resource_group[each.value.resource_group_key].resource.location
  name                                             = "${each.value.name}-${module.aks_naming[each.key].kubernetes_cluster.name_unique}"
  resource_group_name                              = try(module.resource_group[each.value.resource_group_key].name, each.value.resource_group_name)
  tags                                             = local.globals.tags.enabled ? merge(local.globals.tags.object, try(each.value.tags, {})) : try(each.value.tags, {})
  workload_identity_enabled                        = try(each.value.workload_identity_enabled, false)
  oidc_issuer_enabled                              = try(each.value.oidc_issuer_enabled, false)
  
  azure_active_directory_role_based_access_control = try(each.value.azure_active_directory_role_based_access_control, {})

  dns_prefix = each.value.dns_prefix

  maintenance_window_auto_upgrade = try(each.value.maintenance_window_auto_upgrade, {})

  managed_identities = try(each.value.managed_identities, {})

  network_profile = try(each.value.network_profile, {})

  node_pools = try(each.value.node_pools, {})
}
