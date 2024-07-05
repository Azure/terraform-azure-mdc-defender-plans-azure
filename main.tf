locals {
  plans_without_databases = contains(var.mdc_plans_list, "Databases") ? setsubtract(setunion(var.mdc_plans_list, var.mdc_databases_plans), ["Databases"]) : var.mdc_plans_list
}

data "azurerm_subscription" "current" {}

resource "azurerm_security_center_subscription_pricing" "asc_plans" {
  for_each = local.plans_without_databases

  tier          = var.default_tier
  resource_type = each.value
  # Apply subplan only For "StorageAccounts". For other plans, subplan is null.
  subplan = lookup(var.subplans, each.key, each.key == "StorageAccounts" ? "DefenderForStorageV2" : var.default_subplan)

  dynamic "extension" {
    for_each = each.key == "VirtualMachines" || each.key == "CloudPosture" ? [1] : []
    content {
      name = "AgentlessVmScanning"
      additional_extension_properties = {
        ExclusionTags = "[]"
      }
    }
  }
  dynamic "extension" {
    for_each = each.key == "Containers" || each.key == "CloudPosture" ? [1] : []
    content {
      name = "ContainerRegistriesVulnerabilityAssessments"
    }
  }
  dynamic "extension" {
    for_each = each.key == "Containers" || each.key == "CloudPosture" ? [1] : []
    content {
      name = "AgentlessDiscoveryForKubernetes"
    }
  }
  dynamic "extension" {
    for_each = each.key == "StorageAccounts" ? [1] : []
    content {
      name = "OnUploadMalwareScanning"
      additional_extension_properties = {
        CapGBPerMonthPerStorageAccount = "5000"
      }
    }
  }
  dynamic "extension" {
    for_each = each.key == "CloudPosture" || each.key == "StorageAccounts" ? [1] : []
    content {
      name = "SensitiveDataDiscovery"
    }
  }
  dynamic "extension" {
    for_each = each.key == "CloudPosture" ? [1] : []
    content {
      name = "EntraPermissionsManagement"
    }
  }
}
