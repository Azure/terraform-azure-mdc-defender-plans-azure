resource "azurerm_security_center_subscription_pricing" "cloudposture" {
  count = contains(var.mdc_plans_list, "CloudPosture") ? 1 : 0

  tier          = "Standard"
  resource_type = "CloudPosture"

  extension {
    name = "SensitiveDataDiscovery"
  }
  extension {
    name = "ContainerRegistriesVulnerabilityAssessments"
  }
  extension {
    name = "AgentlessDiscoveryForKubernetes"
  }
  extension {
    name = "AgentlessVmScanning"
    additional_extension_properties = {
      ExclusionTags = "[]"
    }
  }

  # Preview - Permissions Management
  extension {
    name = "EntraPermissionsManagement"
  }
}
