resource "azurerm_federated_identity_credential" "federated" {
  for_each = {
    for key, value in try(var.federated_identity_credentials, {}) : key => value
    if value.enabled == true
  }

  name                = each.value.name
  issuer              = each.value.issuer
  subject             = each.value.subject
  audience            = try(each.value.audience, ["api://AzureADTokenExchange"])
  resource_group_name = try(module.resource_group[each.value.resource_group_key].name, each.value.resource_group_name)
  parent_id           = try(module.user_managed_identity[each.value.user_assigned_managed_identity_key].resource_id, each.value.identity_id)
}