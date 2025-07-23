module "user_managed_identity" {
  source  = "Azure/avm-res-managedidentity-userassignedidentity/azurerm"
  version = "0.3.4"

  for_each = {
    for key, value in try(local.user_managed_identity, {}) : key => value
    if value.enabled == true
  }

  location            = try(module.resource_group[each.value.resource_group_key].resource.location, each.value.location)
  name                = try("${each.value.name}-${module.uami_naming[each.key].user_assigned_identity.name_unique}", each.value.name)
  resource_group_name = try(module.resource_group[each.value.resource_group_key].name, each.value.resource_group_name)
  enable_telemetry    = try(each.value.enable_telemetry, false)
}