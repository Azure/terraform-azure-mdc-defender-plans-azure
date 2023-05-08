variable "mdc_plans_list" {
  type = set(string)
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
  description = "(Optional) Set of all MDC plans"
}

variable "status" {
  type        = bool
  default     = true
  description = "(Optional) The status to use. Valid values are `true` for enable, `false` for disable."
}

variable "subplans" {
  type = map(string)
  default = {
    "VirtualMachines" : "P2"
  }
  description = "(Optional) A map of resource type pricing subplan, the key is resource type. This variable takes precedence over `var.default_subplan`. Contact your MSFT representative for possible values"
}
