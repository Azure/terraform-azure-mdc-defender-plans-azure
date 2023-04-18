variable "management_group_id" {
  type        = string
  description = "(Requierd) the ID of your management group to apply the MDC plan to all subscriptions in the management group"
  default     = ""
}

variable "mdc_plans_list" {
  type        = set(string)
  description = "(Optional) Set of all MDC plans"
  default = [
    "AppServices",
    "Arm",
    "CloudPosture",
    "Containers",
    "Dns",
    "KeyVaults",
    "OpenSourceRelationalDatabases",
    "SqlServers",
    "SqlServerVirtualMachines",
    "CosmosDbs",
    "StorageAccounts",
    "VirtualMachines",
  ]
}

variable "status" {
  type        = bool
  description = "(Optional) The status to use. Valid values are (`true`, `false`)"
  default     = true
}

variable "subplans" {
  type        = map(string)
  description = "(Optional) A map of resource type pricing subplan, the key is resource type. This variable takes precedence over `var.default_subplan`. Contact your MSFT representative for possible values"
  default = {
    "VirtualMachines" : "P2"
  }
}
