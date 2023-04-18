# Microsoft Defender for Cloud

Terraform module for MDC onboarding

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name                                                                      | Version        |
|---------------------------------------------------------------------------|----------------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3         |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm)       | >= 3.47, < 4.0 |

## Providers

| Name                                                          | Version        |
|---------------------------------------------------------------|----------------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.47, < 4.0 |

## Modules

No modules.

## Resources

| Name                                                                                                                                                                                | Type        |
|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------|
| [azurerm_role_assignment.va_auto_provisioning_containers_role](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment)                     | resource    |
| [azurerm_role_assignment.va_auto_provisioning_la_role](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment)                             | resource    |
| [azurerm_role_assignment.va_auto_provisioning_vm_role](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment)                             | resource    |
| [azurerm_security_center_auto_provisioning.auto_provisioning](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/security_center_auto_provisioning)    | resource    |
| [azurerm_security_center_auto_provisioning.la_auto_provisioning](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/security_center_auto_provisioning) | resource    |
| [azurerm_security_center_setting.setting_mcas](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/security_center_setting)                             | resource    |
| [azurerm_security_center_subscription_pricing.asc_plans](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/security_center_subscription_pricing)      | resource    |
| [azurerm_subscription_policy_assignment.container](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subscription_policy_assignment)                  | resource    |
| [azurerm_subscription_policy_assignment.sql](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subscription_policy_assignment)                        | resource    |
| [azurerm_subscription_policy_assignment.vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subscription_policy_assignment)                         | resource    |
| [azurerm_policy_definition.container_policies](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/policy_definition)                                | data source |
| [azurerm_policy_definition.la_policies](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/policy_definition)                                       | data source |
| [azurerm_policy_definition.vm_policies](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/policy_definition)                                       | data source |
| [azurerm_role_definition.container_roles](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/role_definition)                                       | data source |
| [azurerm_role_definition.la_roles](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/role_definition)                                              | data source |
| [azurerm_role_definition.vm_roles](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/role_definition)                                              | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription)                                                     | data source |

## Inputs

| Name                                                                                            | Description                                                                                                                                                                                  | Type          | Default                                                                                                                                                                                                                                                                            | Required |
|-------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:--------:|
| <a name="input_default_status"></a> [default\_status](#input\_default\_status)                  | (Optional) Default status to use. Valid values are `true` for enable, `false` for disable.                                                                                                   | `bool`        | `true`                                                                                                                                                                                                                                                                             |    no    |
| <a name="input_default_subplan"></a> [default\_subplan](#input\_default\_subplan)               | (Optional) Resource type pricing default subplan. Contact your MSFT representative for possible values                                                                                       | `string`      | `null`                                                                                                                                                                                                                                                                             |    no    |
| <a name="input_location"></a> [location](#input\_location)                                      | (Optional) The location/region where the policy should exist.                                                                                                                                | `string`      | `"West Europe"`                                                                                                                                                                                                                                                                    |    no    |
| <a name="input_mdc_databases_plans"></a> [mdc\_databases\_plans](#input\_mdc\_databases\_plans) | (Optional) Set of all MDC databases plans                                                                                                                                                    | `set(string)` | <pre>[<br>  "OpenSourceRelationalDatabases",<br>  "SqlServers",<br>  "SqlServerVirtualMachines",<br>  "CosmosDbs"<br>]</pre>                                                                                                                                                       |    no    |
| <a name="input_mdc_plans_list"></a> [mdc\_plans\_list](#input\_mdc\_plans\_list)                | (Optional) Set of all MDC plans                                                                                                                                                              | `set(string)` | <pre>[<br>  "AppServices",<br>  "Arm",<br>  "CloudPosture",<br>  "Containers",<br>  "Dns",<br>  "KeyVaults",<br>  "OpenSourceRelationalDatabases",<br>  "SqlServers",<br>  "SqlServerVirtualMachines",<br>  "CosmosDbs",<br>  "StorageAccounts",<br>  "VirtualMachines"<br>]</pre> |    no    |
| <a name="input_statuses"></a> [statuses](#input\_statuses)                                      | (Optional) A map of the status to use, the key is resource type and the value is status. This variable takes precedence over `var.default_status`.                                           | `map(bool)`   | `{}`                                                                                                                                                                                                                                                                               |    no    |
| <a name="input_subplans"></a> [subplans](#input\_subplans)                                      | (Optional) A map of resource type pricing subplan, the key is resource type. This variable takes precedence over `var.default_subplan`. Contact your MSFT representative for possible values | `map(string)` | `{}`                                                                                                                                                                                                                                                                               |    no    |

## Outputs

| Name                                                                                                          | Description                 |
|---------------------------------------------------------------------------------------------------------------|-----------------------------|
| <a name="output_plans_details"></a> [plans\_details](#output\_plans\_details)                                 | All plans details           |
| <a name="output_subscription_pricing_id"></a> [subscription\_pricing\_id](#output\_subscription\_pricing\_id) | The subscription pricing ID |
<!-- END_TF_DOCS -->
