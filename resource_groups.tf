module "resource_group" {
  for_each = {
    for key, value in try(local.resource_groups, {}) : key => value
    if value.enabled == true
  }

  source           = "Azure/avm-res-resources-resourcegroup/azurerm"
  version          = "0.2.1"
  enable_telemetry = false

  name     = "${each.value.name}-${module.rg_naming[each.key].resource_group.name_unique}"
  location = each.value.location
  tags     = local.globals.tags.enabled ? merge(local.globals.tags.object, try(each.value.tags, {})) : try(each.value.tags, {})
}
