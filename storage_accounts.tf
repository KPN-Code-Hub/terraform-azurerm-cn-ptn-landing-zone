module "storage_accounts" {
  source  = "Azure/avm-res-storage-storageaccount/azurerm"
  version = "0.6.3"

  for_each = try(local.storage_accounts, {})

  location            = module.resource_group[each.value.resource_group_key].resource.location
  resource_group_name = module.resource_group[each.value.resource_group_key].name
  name                = "${each.value.name}${module.storage_account_naming[each.key].storage_account.name_unique}"

  account_kind             = try(each.value.account_kind, "StorageV2")
  account_replication_type = try(each.value.account_replication_type, "ZRS")
  account_tier             = try(each.value.account_tier, "Standard")

  azure_files_authentication = try(each.value.azure_files_authentication, {})

  blob_properties = try(each.value.blob_properties, {})

  containers = try(each.value.containers, {})

  https_traffic_only_enabled = try(each.value.https_traffic_only_enabled, true)

  managed_identities = try(each.value.managed_identities, {})

  min_tls_version = try(each.value.min_tls_version, "TLS1_2")

  network_rules = try(each.value.network_rules, {}) == {} ? null : each.value.network_rules

  public_network_access_enabled   = try(each.value.public_network_access_enabled, false)
  allow_nested_items_to_be_public = try(each.value.allow_nested_items_to_be_public, false)

  queues = try(each.value.queues, {})

  role_assignments = try(each.value.role_assignments, {})

  shared_access_key_enabled = try(each.value.shared_access_key_enabled, true)

  shares = try(each.value.shares, {})

  tables = try(each.value.tables, {})

  tags = local.globals.tags.enabled ? merge(local.globals.tags.object, try(each.value.tags, {})) : try(each.value.tags, {})
}
