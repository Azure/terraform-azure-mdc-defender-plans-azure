variable "management_group_id" {
  type        = string
  default     = ""
  description = "(Requierd) the ID of your management group to apply the MDC plan to all subscriptions in the management group"
}

variable "mdc_plans_list" {
  type = set(string)
  default = [
    "AppServices",
    "Arm",
    "CloudPosture",
    "Containers",
    "KeyVaults",
    "OpenSourceRelationalDatabases",
    "SqlServers",
    "SqlServerVirtualMachines",
    "CosmosDbs",
    "StorageAccounts",
    "VirtualMachines",
    "Api",
  ]
  description = "(Optional) Set of all MDC plans"
}

variable "subplans" {
  type = map(string)
  default = {
    "Api" : "P1"
    "Arm" : "PerSubscription"
    "KeyVaults" : "PerKeyVault"
    "StorageAccounts" : "DefenderForStorageV2"
    "VirtualMachines" : "P2"
  }
  description = "(Optional) A map of resource type pricing subplan, the key is resource type. This variable takes precedence over `var.default_subplan`. Contact your MSFT representative for possible values"
}
