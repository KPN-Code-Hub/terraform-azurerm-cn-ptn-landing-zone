module "nsg" {
  source  = "Azure/avm-res-network-networksecuritygroup/azurerm"
  version = "0.5.0"

  for_each = {
    for key, value in try(local.nsg, {}) : key => value
    if value.enabled == true
  }

  resource_group_name = try(module.resource_group[each.value.resource_group_key].name, each.value.resource_group_name)
  name                = "${each.value.name}-${module.nsg_naming[each.key].network_security_group.name_unique}"
  location            = module.resource_group[each.value.resource_group_key].resource.location
  tags                = local.globals.tags.enabled ? merge(local.globals.tags.object, try(each.value.tags, {})) : try(each.value.tags, {})

  security_rules = try(each.value.security_rules, [])
}
