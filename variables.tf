
variable "resource_groups" {
  description = "Map of resource groups to create. Each key is a resource group name, and value is its config."

  type = map(object({
    name     = string
    location = string
    suffix   = optional(list(string), [])
    enabled  = optional(bool, true)
  }))

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

  type = map(object({
    name               = string
    resource_group_key = string
    enable_telemetry   = optional(bool, false)
    enabled            = optional(bool, true)
  }))

  default = {}
}

variable "nsg" {
  description = "Map of Network Security Groups to create, each with dynamic rule sets."

  type = map(object({
    name               = string
    resource_group_key = string
    suffix             = optional(list(string), [])
    enabled            = optional(bool, true)
    tags               = optional(map(string))
    security_rules = optional(map(object({
      name                       = string
      access                     = string
      destination_address_prefix = string
      destination_port_ranges    = list(string)
      direction                  = string
      priority                   = number
      protocol                   = string
      source_address_prefix      = string
      source_port_range          = string
    })), {})
  }))

  default = {}
}

variable "snet" {
  description = "Map of subnets to create, each linked to a virtual network."

  type = map(object({
    name             = string
    vnet_key         = string
    location         = string
    address_prefixes = list(string)
    suffix           = optional(list(string), [])
    enabled          = optional(bool, true)
  }))

  default = {}
}

variable "vnet" {
  description = "Virtual networks to read or create. Read-only VNets are looked up by name and resource group. Write VNets define full configuration."

  type = map(object({
    name                = string
    enabled             = optional(bool, true)
    read                = optional(bool, false)
    location            = optional(string)
    resource_group_key  = optional(string)
    resource_group_name = optional(string)
    address_space       = optional(list(string))
    dns_servers = optional(object({
      dns_servers = list(string)
    }))
    ddos_protection_plan = optional(map(any))
    diagnostic_settings  = optional(map(any))
    enable_vm_protection = optional(bool)
    encryption = optional(object({
      enabled     = bool
      enforcement = optional(string)
    }))
    flow_timeout_in_minutes = optional(number)
    role_assignments        = optional(map(any))

    subnets = optional(map(object({
      name                            = string
      address_prefixes                = list(string)
      default_outbound_access_enabled = optional(bool)
      delegation = optional(list(object({
        name = string
        service_delegation = object({
          name = string
        })
      })))
      nat_gateway               = optional(map(any))
      network_security_group    = optional(map(any))
      route_table               = optional(map(any))
      service_endpoints         = optional(list(string))
      service_endpoint_policies = optional(map(any))
      role_assignments          = optional(map(any))
    })))
  }))

  default = {}
}

variable "keyvaults" {
  description = "Map of Azure Key Vaults to create, including network rules, RBAC, and optional legacy access."

  type = map(object({
    name                          = string
    location                      = string
    resource_group_key            = string
    enabled                       = optional(bool, true)
    suffix                        = optional(list(string), [])
    enable_telemetry              = optional(bool, false)
    tenant_id                     = optional(string)
    public_network_access_enabled = optional(bool)
    private_endpoints = optional(map(object({
      private_dns_zone_resource_ids = optional(list(string))
      subnet_resource_id            = optional(string)
    })))
    legacy_access_policies_enabled = optional(bool, false)
    legacy_access_policies = optional(map(object({
      object_id               = string
      certificate_permissions = optional(list(string), [])
    })))
    diagnostic_settings = optional(map(object({
      name                           = string
      workspace_resource_id          = string
      log_analytics_destination_type = optional(string)
    })))
    role_assignments = optional(map(object({
      role_definition_id_or_name = string
      principal_id               = string
    })))
    wait_for_rbac_before_key_operations = optional(object({
      create = optional(string)
    }))
    network_acls = optional(object({
      bypass                     = optional(string)
      default_action             = optional(string, "Deny")
      ip_rules                   = optional(list(string))
      virtual_network_subnet_ids = optional(list(string))
    }))
  }))

  default = {}
}

variable "role_assignments_entra_id" {
  description = "Entra ID-based role assignments."

  type = map(object({
    app_scope_id        = optional(string)
    directory_scope_id  = optional(string)
    principal_object_id = optional(string)
    role_id             = optional(string)
  }))

  default = {}
}

variable "role_assignments_resource_manager" {
  description = "Azure Resource Manager role assignments."

  type = map(object({
    role_definition_id                     = optional(string)
    role_definition_name                   = optional(string)
    principal_type                         = optional(string)
    principal_id                           = optional(string)
    scope                                  = optional(string)
    condition                              = optional(string)
    condition_version                      = optional(string)
    delegated_managed_identity_resource_id = optional(string)
    description                            = optional(string)
    skip_service_principal_aad_check       = optional(bool)
  }))

  default = {}
}

variable "storage_accounts" {
  description = "Map of storage accounts to create with optional containers, network rules, identities, and TLS settings."

  type = map(object({
    name                            = string
    location                        = string
    resource_group_key              = string
    suffix                          = optional(list(string), [])
    enabled                         = optional(bool, true)
    account_kind                    = string
    account_replication_type        = string
    account_tier                    = string
    https_traffic_only_enabled      = optional(bool)
    min_tls_version                 = optional(string)
    public_network_access_enabled   = optional(bool)
    shared_access_key_enabled       = optional(bool)
    allow_nested_items_to_be_public = optional(bool)
    enable_telemetry                = optional(bool)
    tags                            = optional(map(string))

    azure_files_authentication = optional(object({
      default_share_level_permission = optional(string)
      directory_type                 = optional(string)
    }))

    blob_properties = optional(object({
      versioning_enabled = optional(bool)
    }))

    containers = optional(map(object({
      name          = string
      public_access = optional(string)
    })))

    managed_identities = optional(object({
      system_assigned = optional(bool)
    }))

    network_rules = optional(object({
      bypass         = optional(list(string))
      default_action = optional(string)
    }))
  }))

  default = {}
}

variable "aks" {
  description = "AKS clusters to create with default and additional node pools, RBAC, networking, and other cluster configuration."

  type = map(object({
    name                      = string
    resource_group_key        = string
    suffix                    = optional(list(string), [])
    enabled                   = optional(bool, true)
    enable_telemetry          = optional(bool, false)
    dns_prefix                = optional(string)
    workload_identity_enabled = optional(bool, true)
    oidc_issuer_enabled       = optional(bool, true)

    default_node_pool = object({
      name                        = string
      temporary_name_for_rotation = optional(string, null)
      vm_size                     = string
      node_count                  = number
      min_count                   = number
      max_count                   = number
      auto_scaling_enabled        = bool
      upgrade_settings = optional(object({
        max_surge = string
      }))
      vnet_subnet_id = string
    })

    node_pools = optional(map(object({
      name                        = string
      vm_size                     = string
      auto_scaling_enabled        = bool
      temporary_name_for_rotation = optional(string, null)
      max_count                   = number
      min_count                   = number
      max_pods                    = optional(number)
      os_disk_size_gb             = optional(number)
      upgrade_settings = optional(object({
        max_surge = string
      }))
      vnet_subnet_id = string
    })))

    azure_active_directory_role_based_access_control = optional(object({
      azure_rbac_enabled = optional(bool)
      tenant_id          = optional(string)
    }))

    network_profile = optional(object({
      network_plugin      = string
      network_mode        = optional(string)
      network_policy      = optional(string)
      dns_service_ip      = optional(string)
      network_data_plane  = optional(string)
      network_plugin_mode = optional(string)
      outbound_type       = optional(string, "loadBalancer")
      pod_cidr            = optional(string)
      pod_cidrs           = optional(list(string))
      service_cidr        = optional(string)
      service_cidrs       = optional(list(string))
      ip_versions         = optional(list(string))
      load_balancer_sku   = optional(string)
      load_balancer_profile = optional(object({
        managed_outbound_ip_count   = optional(number)
        managed_outbound_ipv6_count = optional(number)
        outbound_ip_address_ids     = optional(list(string))
        outbound_ip_prefix_ids      = optional(list(string))
        outbound_ports_allocated    = optional(number)
        idle_timeout_in_minutes     = optional(number)
      }))
      nat_gateway_profile = optional(object({
        managed_outbound_ip_count = optional(number)
        idle_timeout_in_minutes   = optional(number)
      }))
    }))

    maintenance_window_auto_upgrade = optional(object({
      frequency   = string
      interval    = string
      day_of_week = string
      duration    = number
      utc_offset  = string
      start_time  = string
      start_date  = string
    }))

    managed_identities = optional(object({
      system_assigned = optional(bool)
    }))
  }))

  default = {}
}

variable "federated_identity_credentials" {
  description = "Map of federated identity credentials to create."

  type = map(object({
    enabled                            = optional(bool, true)
    name                               = optional(string)
    issuer                             = optional(string)
    subject                            = optional(string)
    audience                           = optional(list(string), ["api://AzureADTokenExchange"])
    resource_group_name                = optional(string, null)
    resource_group_key                 = optional(string, null)
    identity_id                        = optional(string, null)
    user_assigned_managed_identity_key = optional(string, null)
  }))

  default = {}
}

variable "container_registry" {
  description = "Container registry"

  type = map(object({
    name                   = string
    resource_group_key     = optional(string)
    resource_group_name    = optional(string)
    admin_enabled          = optional(bool, false)
    anonymous_pull_enabled = optional(bool, false)
    customer_managed_key = optional(object({
      key_vault_resource_id = string
      key_name              = string
      key_version           = optional(string, null)
      user_assigned_identity = optional(object({
        resource_id = string
      }), null)
    }), null)
    data_endpoint_enabled = optional(bool, false)
    diagnostic_settings = optional(map(object({
      name                                     = optional(string, null)
      log_categories                           = optional(set(string), [])
      log_groups                               = optional(set(string), ["allLogs"])
      metric_categories                        = optional(set(string), ["AllMetrics"])
      log_analytics_destination_type           = optional(string, "Dedicated")
      workspace_resource_id                    = optional(string, null)
      storage_account_resource_id              = optional(string, null)
      event_hub_authorization_rule_resource_id = optional(string, null)
      event_hub_name                           = optional(string, null)
      marketplace_partner_resource_id          = optional(string, null)
    })), {})
    enable_telemetry      = optional(bool, true)
    enable_trust_policy   = optional(bool, false)
    export_policy_enabled = optional(bool, true)
    georeplications = optional(list(object({
      location                  = string
      regional_endpoint_enabled = optional(bool, true)
      zone_redundancy_enabled   = optional(bool, true)
      tags                      = optional(map(any), null)
    })), [])
    lock = optional(object({
      kind = string
      name = optional(string, null)
    }), null)
    managed_identities = optional(object({
      system_assigned            = optional(bool, false)
      user_assigned_resource_ids = optional(set(string), [])
    }), {})
    network_rule_bypass_option = optional(string, "None")
    network_rule_set = optional(object({
      default_action = optional(string, "Deny")
      ip_rule = optional(list(object({
        action   = optional(string, "Allow")
        ip_range = string
      })), [])
    }), null)
    private_endpoints = optional(map(object({
      name = optional(string, null)
      role_assignments = optional(map(object({
        role_definition_id_or_name             = string
        principal_id                           = string
        description                            = optional(string, null)
        skip_service_principal_aad_check       = optional(bool, false)
        condition                              = optional(string, null)
        condition_version                      = optional(string, null)
        delegated_managed_identity_resource_id = optional(string, null)
        principal_type                         = optional(string, null)
      })), {})
      lock = optional(object({
        kind = string
        name = optional(string, null)
      }), null)
      tags                                    = optional(map(string), null)
      subnet_resource_id                      = string
      private_dns_zone_group_name             = optional(string, "default")
      private_dns_zone_resource_ids           = optional(set(string), [])
      application_security_group_associations = optional(map(string), {})
      private_service_connection_name         = optional(string, null)
      network_interface_name                  = optional(string, null)
      location                                = optional(string, null)
      resource_group_name                     = optional(string, null)
      ip_configurations = optional(map(object({
        name               = string
        private_ip_address = string
      })), {})
    })), {})
    private_endpoints_manage_dns_zone_group = optional(bool, true)
    public_network_access_enabled           = optional(bool, true)
    quarantine_policy_enabled               = optional(bool, false)
    retention_policy_in_days                = optional(number, 7)
    role_assignments = optional(map(object({
      role_definition_id_or_name             = string
      principal_id                           = string
      description                            = optional(string, null)
      skip_service_principal_aad_check       = optional(bool, false)
      condition                              = optional(string, null)
      condition_version                      = optional(string, null)
      delegated_managed_identity_resource_id = optional(string, null)
      principal_type                         = optional(string, null)
    })), {})
    sku                     = optional(string, "Premium")
    tags                    = optional(map(string), null)
    zone_redundancy_enabled = optional(bool, true)
    enabled                 = optional(bool, true)
  }))

  default = {}
}
