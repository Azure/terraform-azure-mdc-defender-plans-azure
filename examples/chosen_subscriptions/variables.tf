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

variable "subscription_id" {
  type        = string
  description = "(Required) a subscription id to apply the MDC plan to"
  default     = ""
}

variable "subscription_id2" {
  type        = string
  description = "(Required) a subscription id to apply the MDC plan to"
  default     = ""
}
