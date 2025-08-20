
variable "resource_groups" {
  default = {}
}

variable "globals" {
  description = "Global configuration values used across modules."

  type = map(object({
    name    = string
    enabled = optional(bool, true)
    list    = optional(list(string))
    object  = optional(map(string))
  }))

  default = {}
}

variable "user_managed_identity" {
  description = "Map of user managed identities to create."
  default = {}
}

variable "nsg" {
  description = "Map of Network Security Groups to create, each with dynamic rule sets."
  default = {}
}

variable "snet" {
  description = "Map of subnets to create, each linked to a virtual network."
  default = {}
}

variable "vnet" {
  description = "Virtual networks to read or create. Read-only VNets are looked up by name and resource group. Write VNets define full configuration."
  default = {}
}

variable "keyvaults" {
  description = "Map of Azure Key Vaults to create, including network rules, RBAC, and optional legacy access."
  default = {}
}

variable "role_assignments_entra_id" {
  description = "Entra ID-based role assignments."
  default = {}
}

variable "role_assignments_resource_manager" {
  description = "Azure Resource Manager role assignments."
  default = {}
}

variable "storage_accounts" {
  description = "Map of storage accounts to create with optional containers, network rules, identities, and TLS settings."
  default = {}
}

variable "aks" {
  description = "AKS clusters to create with default and additional node pools, RBAC, networking, and other cluster configuration."
  default = {}
}

variable "federated_identity_credentials" {
  description = "Map of federated identity credentials to create."
  default = {}
}

variable "container_registry" {
  description = "Container registry"
  default = {}
}
