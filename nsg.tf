module "nsg" {
  source  = "Azure/avm-res-network-networksecuritygroup/azurerm"
  version = "0.4.0"

  for_each = try(local.nsg, {})

  resource_group_name = module.resource_group[each.value.resource_group_key].name
  name                = "${each.value.name}-${module.nsg_naming[each.key].network_security_group.name_unique}"
  location            = module.resource_group[each.value.resource_group_key].resource.location
  tags                = local.globals.tags.enabled ? merge(local.globals.tags.object, try(each.value.tags, {})) : try(each.value.tags, {})

  security_rules = try(each.value.security_rules, [])
}
