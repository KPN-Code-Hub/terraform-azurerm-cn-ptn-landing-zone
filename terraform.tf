terraform {
  required_version = ">= 1.9, < 2.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.0.0, < 5.0.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5"
    }
    azapi = {
      source = "Azure/azapi"
    }
  }
}

provider "azapi" {
  subscription_id           = "10852416-5fc2-40e3-a117-ae3bc1499f07"
  tenant_id                 = "0baeb517-c6ec-4d6c-a394-96a5affa5ada"
  client_id                 = "ac734034-cf2e-464e-9952-e57fa223a9d6"
  use_aks_workload_identity = true
}

data "azurerm_client_config" "current" {}
