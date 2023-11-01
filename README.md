# terraform-azure-mdc-defender-plans-azure

-> **NOTE:** When running the module, your subscription should not already be onboarded to MDC. If you have already completed the onboarding process, please refer to the  [Onboarded Azure Subscription](#onboarded-azure-subscription) section.

~> **NOTE:** Deletion of the resource will reset the pricing tier to `Free`

## Onboarding to Microsoft Defender for Cloud (MDC) plans in Azure

This Terraform module activate Microsoft Defender for Cloud (MDC) plans.

The module supports the following onboarding types:

1. <u>Single Subscription</u>: Onboard MDC plans for a single subscription.
2. <u>Chosen Subscriptions</u>: Onboard MDC plans for a selected list of subscriptions.
3. <u>All Subscriptions</u>: Onboard MDC plans for all subscriptions where your account holds owner permissions.
4. <u>Management Group</u>: Onboard MDC plans for all subscriptions within a designated management group.

### Terraform and terraform-provider-azurerm version restrictions

Terraform core's version is v1.x and terraform-provider-azurerm's version is v3.x.

## Usage

### Enable plans

To enable plans using this module, follow these steps based on the subscription type:

#### Single Subscription

1. Navigate to `examples\single_subscription` folder.
2. Execute the `terraform apply` command.
3. Your onboarding will be applied exclusively to the subscription you are currently connected to.

#### Chosen Subscriptions / All Subscriptions / Management Group

1. Enter the relevant folder under `examples` based on your scenario.
2. Execute the `terraform apply` command.
3. After the execution, a new directory named `output` will be generated within the example folder.
4. Access the newly created `output` folder.
5. Modify the `main.tf` file within this folder to align with your specific requirements.
6. Execute the `terraform apply` command again to apply your modifications.

### Disable plans

* To disable all plans execute `terraform destroy` command.
* To disable a specific plan, remove the plan name from mdc_plans_list var and execute `terraform apply` command.

### Onboarded Azure Subscription
We recommend managing the entire onboarding process with our module. If you've already onboarded your Azure Subscription to Microsoft Defender for Cloud plans, you have several options:

#### Azure Defender Plans UI Portal
* **Manual Cleanup**: Manually toggle off the status of all MDC plans.

#### Terraform CLI
* **Start Fresh**: You can choose to destroy your current Terraform environment and begin anew.
* **Import Existing Resources**: Utilize [Terraform import](https://developer.hashicorp.com/terraform/cli/import) to seamlessly integrate existing resources into Terraform management.
* **Manage Multiple Terraform States**: Maintain your current state and create a new one for this module, allowing for efficient resource management.

## Telemetry Collection

This module uses [terraform-provider-modtm](https://registry.terraform.io/providers/Azure/modtm/latest) to collect telemetry data. This provider is designed to assist with tracking the usage of Terraform modules. It creates a custom `modtm_telemetry` resource that gathers and sends telemetry data to a specified endpoint. The aim is to provide visibility into the lifecycle of your Terraform modules - whether they are being created, updated, or deleted. This data can be invaluable in understanding the usage patterns of your modules, identifying popular modules, and recognizing those that are no longer in use.

The ModTM provider is designed with respect for data privacy and control. The only data collected and transmitted are the tags you define in module's `modtm_telemetry` resource, an uuid which represents a module instance's identifier, and the operation the module's caller is executing (Create/Update/Delete/Read). No other data from your Terraform modules or your environment is collected or transmitted.

One of the primary design principles of the ModTM provider is its non-blocking nature. The provider is designed to work in a way that any network disconnectedness or errors during the telemetry data sending process will not cause a Terraform error or interrupt your Terraform operations. This makes the ModTM provider safe to use even in network-restricted or air-gaped environments.

If the telemetry data cannot be sent due to network issues, the failure will be logged, but it will not affect the Terraform operation in progress(it might delay your operations for no more than 5 seconds). This ensures that your Terraform operations always run smoothly and without interruptions, regardless of the network conditions.

You can turn off the telemetry collection by declaring the following `provider` block in your root module:

```hcl
provider "modtm" {
  enabled = false
}
```

## Contributing
### Configurations

- [Configure Terraform for Azure](https://docs.microsoft.com/en-us/azure/virtual-machines/linux/terraform-install-configure)

We assumed that you have setup service principal's credentials in your environment variables like below:

```shell
export ARM_SUBSCRIPTION_ID="<azure_subscription_id>"
export ARM_TENANT_ID="<azure_subscription_tenant_id>"
export ARM_CLIENT_ID="<service_principal_appid>"
export ARM_CLIENT_SECRET="<service_principal_password>"
```

On Windows Powershell:

```shell
$env:ARM_SUBSCRIPTION_ID="<azure_subscription_id>"
$env:ARM_TENANT_ID="<azure_subscription_tenant_id>"
$env:ARM_CLIENT_ID="<service_principal_appid>"
$env:ARM_CLIENT_SECRET="<service_principal_password>"
```

### Pre-Commit & Pr-Check &  E2E Test

We provide a docker image to run the pre-commit checks and tests for you: `mcr.microsoft.com/azterraform:latest`

To run the pre-commit task, we can run the following command:

```shell
$ docker run --rm -v $(pwd):/src -w /src mcr.microsoft.com/azterraform:latest make pre-commit
```

On Windows Powershell:

```shell
$ docker run --rm -v ${pwd}:/src -w /src mcr.microsoft.com/azterraform:latest make pre-commit
```

In pre-commit task, we will:

1. Run `terraform fmt -recursive` command for your Terraform code.
2. Run `terrafmt fmt -f` command for markdown files and go code files to ensure that the Terraform code embedded in these files are well formatted.
3. Run `go mod tidy` and `go mod vendor` for test folder to ensure that all the dependencies have been synced.
4. Run `gofmt` for all go code files.
5. Run `gofumpt` for all go code files.
6. Run `terraform-docs` on `README.md` file, then run `markdown-table-formatter` to format markdown tables in `README.md`.

Then we can run the pr-check task to check whether our code meets our pipeline's requirement (We strongly recommend you run the following command before you commit):

```shell
$ docker run --rm -v $(pwd):/src -w /src mcr.microsoft.com/azterraform:latest make pr-check
```

On Windows Powershell:

```shell
$ docker run --rm -v ${pwd}:/src -w /src mcr.microsoft.com/azterraform:latest make pr-check
```

To run the e2e-test, we can run the following command:

```text
docker run --rm -v $(pwd):/src -w /src -e ARM_SUBSCRIPTION_ID -e ARM_TENANT_ID -e ARM_CLIENT_ID -e ARM_CLIENT_SECRET mcr.microsoft.com/azterraform:latest make e2e-test
```

On Windows Powershell:

```text
docker run --rm -v ${pwd}:/src -w /src -e ARM_SUBSCRIPTION_ID -e ARM_TENANT_ID -e ARM_CLIENT_ID -e ARM_CLIENT_SECRET mcr.microsoft.com/azterraform:latest make e2e-test
```
#### Notice to contributor

This project welcomes contributions and suggestions.  Most contributions require you to agree to a
Contributor License Agreement (CLA) declaring that you have the right to, and actually do, grant us
the rights to use your contribution. For details, visit https://cla.microsoft.com.

When you submit a pull request, a CLA-bot will automatically determine whether you need to provide
a CLA and decorate the PR appropriately (e.g., label, comment). Simply follow the instructions
provided by the bot. You will only need to do this once across all repos using our CLA.

This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/).
For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or
contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments.

## Authors

Originally created by [Eli Betito](https://github.com/elibetito-microsoft) and [Ori Ben Arzty](https://github.com/oribenartzyM)

## License

[MIT](LICENSE)

## Module Spec

The following sections are generated by [terraform-docs](https://github.com/terraform-docs/terraform-docs) and [markdown-table-formatter](https://github.com/nvuillam/markdown-table-formatter), please **DO NOT MODIFY THEM MANUALLY!**

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.47, < 4.0 |
| <a name="requirement_modtm"></a> [modtm](#requirement\_modtm) | >= 0.1.8, < 1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.47, < 4.0 |
| <a name="provider_modtm"></a> [modtm](#provider\_modtm) | >= 0.1.8, < 1.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_role_assignment.va_auto_provisioning_containers_role](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.va_auto_provisioning_la_role](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.va_auto_provisioning_vm_role](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_security_center_auto_provisioning.auto_provisioning](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/security_center_auto_provisioning) | resource |
| [azurerm_security_center_auto_provisioning.la_auto_provisioning](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/security_center_auto_provisioning) | resource |
| [azurerm_security_center_setting.setting_mcas](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/security_center_setting) | resource |
| [azurerm_security_center_subscription_pricing.asc_plans](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/security_center_subscription_pricing) | resource |
| [azurerm_security_center_subscription_pricing.cloudposture](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/security_center_subscription_pricing) | resource |
| [azurerm_subscription_policy_assignment.container](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subscription_policy_assignment) | resource |
| [azurerm_subscription_policy_assignment.sql](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subscription_policy_assignment) | resource |
| [azurerm_subscription_policy_assignment.vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subscription_policy_assignment) | resource |
| [modtm_telemetry.this](https://registry.terraform.io/providers/Azure/modtm/latest/docs/resources/telemetry) | resource |
| [azurerm_policy_definition.container_policies](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/policy_definition) | data source |
| [azurerm_policy_definition.la_policies](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/policy_definition) | data source |
| [azurerm_policy_definition.vm_policies](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/policy_definition) | data source |
| [azurerm_role_definition.container_roles](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/role_definition) | data source |
| [azurerm_role_definition.la_roles](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/role_definition) | data source |
| [azurerm_role_definition.vm_roles](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/role_definition) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_default_subplan"></a> [default\_subplan](#input\_default\_subplan) | (Optional) Resource type pricing default subplan. Contact your MSFT representative for possible values | `string` | `null` | no |
| <a name="input_default_tier"></a> [default\_tier](#input\_default\_tier) | (Optional) The pricing tier to use. Possible values are `Free` and `Standard` | `string` | `"Standard"` | no |
| <a name="input_location"></a> [location](#input\_location) | (Optional) The location/region where the policy should exist. | `string` | `"West Europe"` | no |
| <a name="input_mdc_databases_plans"></a> [mdc\_databases\_plans](#input\_mdc\_databases\_plans) | (Optional) Set of all MDC databases plans | `set(string)` | <pre>[<br>  "OpenSourceRelationalDatabases",<br>  "SqlServers",<br>  "SqlServerVirtualMachines",<br>  "CosmosDbs"<br>]</pre> | no |
| <a name="input_mdc_plans_list"></a> [mdc\_plans\_list](#input\_mdc\_plans\_list) | (Optional) Set of all MDC plans | `set(string)` | <pre>[<br>  "AppServices",<br>  "Arm",<br>  "CloudPosture",<br>  "Containers",<br>  "KeyVaults",<br>  "OpenSourceRelationalDatabases",<br>  "SqlServers",<br>  "SqlServerVirtualMachines",<br>  "CosmosDbs",<br>  "StorageAccounts",<br>  "VirtualMachines",<br>  "Api"<br>]</pre> | no |
| <a name="input_subplans"></a> [subplans](#input\_subplans) | (Optional) A map of resource type pricing subplan, the key is resource type. This variable takes precedence over `var.default_subplan`. Contact your MSFT representative for possible values | `map(string)` | `{}` | no |
| <a name="input_tracing_tags_enabled"></a> [tracing\_tags\_enabled](#input\_tracing\_tags\_enabled) | Whether enable tracing tags that generated by BridgeCrew Yor. | `bool` | `false` | no |
| <a name="input_tracing_tags_prefix"></a> [tracing\_tags\_prefix](#input\_tracing\_tags\_prefix) | Default prefix for generated tracing tags | `string` | `"avm_"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_plans_details"></a> [plans\_details](#output\_plans\_details) | All plans details |
| <a name="output_subscription_pricing_id"></a> [subscription\_pricing\_id](#output\_subscription\_pricing\_id) | The subscription pricing ID |
<!-- END_TF_DOCS -->
