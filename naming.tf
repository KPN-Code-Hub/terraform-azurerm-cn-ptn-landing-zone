module "rg_naming" {
  source   = "Azure/naming/azurerm"
  version  = ">= 0.4.0"
  for_each = {
    for key, value in local.resource_groups : key => value
    if try(value.enabled, true)
  }
  suffix = local.globals.suffix.enabled ? local.globals.suffix.list : each.value.suffix
}

module "storage_account_naming" {
  source   = "Azure/naming/azurerm"
  version  = ">= 0.4.0"
  for_each = {
    for key, value in local.storage_accounts : key => value
    if try(value.enabled, true)
  }
  suffix = local.globals.suffix.enabled ? local.globals.suffix.list : each.value.suffix
}

module "aks_naming" {
  source   = "Azure/naming/azurerm"
  version  = ">= 0.4.0"
  for_each = {
    for key, value in local.aks : key => value
    if try(value.enabled, true)
  }
  suffix = local.globals.suffix.enabled ? local.globals.suffix.list : each.value.suffix
}

module "nsg_naming" {
  source   = "Azure/naming/azurerm"
  version  = ">= 0.4.0"
  for_each = {
    for key, value in local.nsg : key => value
    if try(value.enabled, true)
  }
  suffix = local.globals.suffix.enabled ? local.globals.suffix.list : each.value.suffix
}

module "vnet_naming" {
  source   = "Azure/naming/azurerm"
  version  = ">= 0.4.0"
  for_each = {
    for key, value in local.vnet : key => value
    if try(value.read, false) == false && try(value.enabled, true)
  }
  suffix = local.globals.suffix.enabled ? local.globals.suffix.list : each.value.suffix
}

module "snet_naming" {
  source   = "Azure/naming/azurerm"
  version  = ">= 0.4.0"
  for_each = {
    for key, value in local.snet : key => value
    if try(value.enabled, true)
  }
  suffix = local.globals.suffix.enabled ? local.globals.suffix.list : each.value.suffix
}

module "keyvault_naming" {
  source   = "Azure/naming/azurerm"
  version  = ">= 0.4.0"
  for_each = {
    for key, value in local.keyvaults : key => value
    if try(value.enabled, true)
  }
  suffix = local.globals.suffix.enabled ? local.globals.suffix.list : each.value.suffix
}

module "uami_naming" {
  source   = "Azure/naming/azurerm"
  version  = ">= 0.4.0"
  for_each = {
    for key, value in local.user_managed_identity : key => value
    if try(value.enabled, true)
  }
  suffix = local.globals.suffix.enabled ? local.globals.suffix.list : each.value.suffix
}

module "container_registry_naming" {
  source   = "Azure/naming/azurerm"
  version  = ">= 0.4.0"
  for_each = {
    for key, value in local.container_registry : key => value
    if try(value.enabled, true)
  }
  suffix = local.globals.suffix.enabled ? local.globals.suffix.list : each.value.suffix
}