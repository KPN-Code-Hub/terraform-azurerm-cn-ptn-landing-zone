module "rg_naming" {
  source   = "Azure/naming/azurerm"
  version  = " >= 0.4.0"
  for_each = local.resource_groups
  suffix   = local.globals.suffix.enabled ? local.globals.suffix.list : each.value.suffix
}

module "storage_account_naming" {
  source   = "Azure/naming/azurerm"
  version  = " >= 0.4.0"
  for_each = local.storage_accounts
  suffix   = local.globals.suffix.enabled ? local.globals.suffix.list : each.value.suffix
}

module "aks_naming" {
  source   = "Azure/naming/azurerm"
  version  = " >= 0.4.0"
  for_each = local.aks
  suffix   = local.globals.suffix.enabled ? local.globals.suffix.list : each.value.suffix
}

module "nsg_naming" {
  source   = "Azure/naming/azurerm"
  version  = " >= 0.4.0"
  for_each = local.nsg
  suffix   = local.globals.suffix.enabled ? local.globals.suffix.list : each.value.suffix
}

module "vnet_naming" {
  source  = "Azure/naming/azurerm"
  version = " >= 0.4.0"
  for_each = try({
    for key, value in local.vnet : key => value
    if try(value.read, false) == false
  }, {})
  suffix = local.globals.suffix.enabled ? local.globals.suffix.list : each.value.suffix
}

module "snet_naming" {
  source   = "Azure/naming/azurerm"
  version  = " >= 0.4.0"
  for_each = local.snet
  suffix   = local.globals.suffix.enabled ? local.globals.suffix.list : each.value.suffix
}

module "keyvault_naming" {
  source   = "Azure/naming/azurerm"
  version  = " >= 0.4.0"
  for_each = local.keyvaults
  suffix   = local.globals.suffix.enabled ? local.globals.suffix.list : each.value.suffix
}

module "uami_naming" {
  source   = "Azure/naming/azurerm"
  version  = " >= 0.4.0"
  for_each = local.user_managed_identity
  suffix   = local.globals.suffix.enabled ? local.globals.suffix.list : each.value.suffix
}