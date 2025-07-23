module "snet" {
  source  = "Azure/avm-res-network-virtualnetwork/azurerm//modules/subnet"
  version = "0.9.2"

  for_each = try(local.snet, {})

  name = "${each.value.name}${module.snet_naming[each.key].subnet.name_unique}"
  virtual_network = {
    resource_id = try(local.combined_vnet[each.value.vnet_key].resource_id, local.combined_vnet[each.value.vnet_key].id)
  }
  address_prefixes = try(each.value.address_prefixes, [])
}
