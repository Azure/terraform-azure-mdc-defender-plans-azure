variable "default_tier" {
  type        = string
  default     = "Standard"
  description = "(Optional) The pricing tier to use. Possible values are `Free` and `Standard`"
  nullable    = false
}

variable "default_subplan" {
  type        = string
  default     = null
  description = "(Optional) Resource type pricing default subplan. Contact your MSFT representative for possible values"
}

variable "location" {
  type        = string
  default     = "West Europe"
  description = "(Optional) The location/region where the policy should exist."
}

variable "mdc_databases_plans" {
  type = set(string)
  default = [
    "OpenSourceRelationalDatabases",
    "SqlServers",
    "SqlServerVirtualMachines",
    "CosmosDbs",
  ]
  description = "(Optional) Set of all MDC databases plans"
  nullable    = false
}

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
  nullable    = false
}

variable "subplans" {
  type        = map(string)
  default     = {}
  description = "(Optional) A map of resource type pricing subplan, the key is resource type. This variable takes precedence over `var.default_subplan`. Contact your MSFT representative for possible values"
  nullable    = false
}

# tflint-ignore: terraform_unused_declarations
variable "tracing_tags_enabled" {
  type        = bool
  default     = false
  description = "Whether enable tracing tags that generated by BridgeCrew Yor."
  nullable    = false
}

# tflint-ignore: terraform_unused_declarations
variable "tracing_tags_prefix" {
  type        = string
  default     = "avm_"
  description = "Default prefix for generated tracing tags"
  nullable    = false
}
