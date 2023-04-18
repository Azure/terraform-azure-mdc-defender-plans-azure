variable "default_status" {
  type        = bool
  description = "(Optional) Default status to use. Valid values are `true` for enable, `false` for disable."
  default     = true
  nullable    = false
}

variable "default_subplan" {
  type        = string
  description = "(Optional) Resource type pricing default subplan. Contact your MSFT representative for possible values"
  default     = null
}

variable "location" {
  type        = string
  description = "(Optional) The location/region where the policy should exist."
  default     = "West Europe"
}

variable "mdc_databases_plans" {
  type        = set(string)
  description = "(Optional) Set of all MDC databases plans"
  default = [
    "OpenSourceRelationalDatabases",
    "SqlServers",
    "SqlServerVirtualMachines",
    "CosmosDbs",
  ]
  nullable = false
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
  nullable = false
}

variable "statuses" {
  type        = map(bool)
  description = "(Optional) A map of the status to use, the key is resource type and the value is status. This variable takes precedence over `var.default_status`."
  default     = {}
  nullable    = false
}

variable "subplans" {
  type        = map(string)
  description = "(Optional) A map of resource type pricing subplan, the key is resource type. This variable takes precedence over `var.default_subplan`. Contact your MSFT representative for possible values"
  default     = {}
  nullable    = false
}