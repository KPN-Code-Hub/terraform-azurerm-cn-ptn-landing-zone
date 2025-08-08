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
}