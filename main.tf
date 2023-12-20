locals {
  final_plans_list        = contains(var.mdc_plans_list, "CloudPosture") ? setsubtract(setunion(local.plans_without_databases), ["CloudPosture"]) : local.plans_without_databases
  plans_without_databases = contains(var.mdc_plans_list, "Databases") ? setsubtract(setunion(var.mdc_plans_list, var.mdc_databases_plans), ["Databases"]) : var.mdc_plans_list
}

data "azurerm_subscription" "current" {}

resource "azurerm_security_center_subscription_pricing" "asc_plans" {
  for_each = local.final_plans_list

  tier          = var.default_tier
  resource_type = each.value
  # For "StorageAccounts" subplan is "PerStorageAccount". For other plans subplan is null.
  subplan = lookup(var.subplans, each.key, each.key == "StorageAccounts" ? "PerStorageAccount" : var.default_subplan)

  dynamic "extension" {
    for_each = each.key == "VirtualMachines" ? [1] : []
    content {
      name = "AgentlessVmScanning"
      additional_extension_properties = {
        ExclusionTags = "[]"
      }
    }
  }
  dynamic "extension" {
    for_each = each.key == "Containers" ? [1] : []
    content {
      name = "AgentlessDiscoveryForKubernetes"
    }
  }

  dynamic "extension" {
    for_each = each.key == "Containers" ? [1] : []
    content {
      name = "ContainerRegistriesVulnerabilityAssessments"
    }
  }

  dynamic "extension" {
    for_each = each.key == "StorageAccounts" ? [1] : []
    content {
      name = "OnUploadMalwareScanning"
      additional_extension_properties = {
        # Set to -1 to remove the limit, default is 5000GB
        CapGBPerMonthPerStorageAccount = "5000"
      }
    }
  }
  dynamic "extension" {
    for_each = each.key == "StorageAccounts" ? [1] : []
    content {
      name = "SensitiveDataDiscovery"
    }
  }
}
