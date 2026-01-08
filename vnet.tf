data "azurerm_virtual_network" "vnet_read" {
  for_each = try({
    for key, value in local.vnet : key => value
    if try(value.read, false) == true && try(value.enabled, true)
  }, {})
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
}

module "vnet" {
  source  = "Azure/avm-res-network-virtualnetwork/azurerm"
  version = "0.17.0"

  for_each = try({
    for key, value in local.vnet : key => value
    if try(value.read, false) == false && try(value.enabled, true)
  }, {})

  address_space       = try(each.value.address_space, [])
  location            = module.resource_group[each.value.resource_group_key].resource.location
  resource_group_name = try(module.resource_group[each.value.resource_group_key].name, each.value.resource_group_name)
  enable_telemetry    = try(each.value.enable_telemetry, false)
  name                = "${each.value.name}-${module.vnet_naming[each.key].virtual_network.name_unique}"
  tags                = local.globals.tags.enabled ? merge(local.globals.tags.object, try(each.value.tags, {})) : try(each.value.tags, {})

  ddos_protection_plan = try(each.value.ddos_protection_plan, null)

  diagnostic_settings = try(each.value.diagnostic_settings, {})

  dns_servers = {
    dns_servers = try(each.value.dns_servers.dns_servers, [])
  }

  enable_vm_protection = try(each.value.enable_vm_protection, false)

  encryption              = try(each.value.encryption, null)
  flow_timeout_in_minutes = try(each.value.flow_timeout_in_minutes, 30)

  role_assignments = try(each.value.role_assignments, {})

  subnets = try(each.value.subnets, {})
}
