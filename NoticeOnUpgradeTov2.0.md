# Notice on Upgrade to v2.x
V2.0.0 is a major version upgrade and a lot of breaking changes have been introduced. Extreme caution must be taken during the upgrade to avoid resource replacement and downtime by accident.

Running the `terraform plan` first to inspect the plan is strongly advised.

## Upgrade the default subplan for StorageAccounts
Upgrade the Storage Subplan from `PerStorageAccount` to `DefenderForStorageV2` and activate the `Malware scanning` with the default `CapGBPerMonthPerStorageAccount` value set to 5000.

## Removal of extensions_cloud_posture.tf File
The cloudposture extension file has been removed and integrated into the [main.tf](https://github.com/Azure/terraform-azure-mdc-defender-plans-azure/blob/03057fbe3bcfbc5888cafd0390ae0e8356643444/main.tf) file. It is now part of the `azurerm_security_center_subscription_pricing` resource with a dynamic block.

## The following Policies have been renamed for Containers, SQL Server Virtual Machines, and Virtual Machines
### `extensions_containers.tf`
* `mdc-containers-kubernetes1-autoprovisioning` has been renamed to `mdc-containers-kubernetes1-autoprovisioning-containers`
* `mdc-containers-kubernetes2-autoprovisioning` has been renamed to `mdc-cmdc-containers-kubernetes2-autoprovisioning-containers`
* `mdc-containers_aks_autoprovisioning` has been renamed to `mdc-containers_aks_autoprovisioning-containers`
* `mdc-containers-arc-autoprovisioning` has been renamed to `mdc-containers-arc-autoprovisioning-containers`

### `extensions_sql_server_virtual_machines.tf`
* `mdc-log-analytics-arc1-autoprovisioning` has been renamed to `mdc-log-analytics-arc1-autoprovisioning-sql`
* `mdc-log-analytics-arc2-autoprovisioning` has been renamed to `mdc-log-analytics-arc2-autoprovisioning-sql`

### `extensions_virtual_machines.tf`
* `mdc-va-autoprovisioning` has been renamed to `mdc-va-autoprovisioning-vm`
* `mdc-log-analytics-arc1-autoprovisioning` has been renamed to `mdc-log-analytics-arc1-autoprovisioning-vm`
* `mdc-log-analytics-arc2-autoprovisioning` has been renamed to `mdc-log-analytics-arc2-autoprovisioning-vm`


## local.final_plans_list's variable has been removed
The local.final_plans_list variable has been removed and its functionality integrated elsewhere.
