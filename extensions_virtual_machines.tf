locals {
  va_type = jsonencode({
    "vaType" = {
      "value" = "mdeTvm"
    }
  })
  virtual_machine_policies = {
    mdc-va-autoprovisioning-vm = {
      definition_display_name = "Configure machines to receive a vulnerability assessment provider"
    }
  }
  virtual_machine_roles = {
    virtual-machines-va-role-1 = {
      name   = "Security Admin"
      policy = "mdc-va-autoprovisioning-vm"
    }
  }
}

# Enabling vm extensions - Vulnerability assessment
data "azurerm_policy_definition" "vm_policies" {
  for_each = contains(var.mdc_plans_list, "VirtualMachines") ? local.virtual_machine_policies : {}

  display_name = each.value.definition_display_name
}

resource "azurerm_subscription_policy_assignment" "vm" {
  for_each = contains(var.mdc_plans_list, "VirtualMachines") ? local.virtual_machine_policies : {}

  name                 = each.key
  policy_definition_id = data.azurerm_policy_definition.vm_policies[each.key].id
  subscription_id      = data.azurerm_subscription.current.id
  display_name         = each.value.definition_display_name
  location             = var.location
  parameters           = each.key == "mdc-va-autoprovisioning-vm" ? local.va_type : null

  identity {
    type = "SystemAssigned"
  }

  depends_on = [
    azurerm_security_center_subscription_pricing.asc_plans["VirtualMachines"]
  ]
}

# Enabling vm extensions - Endpoint protection
resource "azurerm_security_center_setting" "setting_mcas" {
  count = contains(var.mdc_plans_list, "VirtualMachines") ? 1 : 0

  enabled      = true
  setting_name = "WDATP"

  depends_on = [
    azurerm_security_center_subscription_pricing.asc_plans["VirtualMachines"]
  ]
}

# Enabling vm Roles
data "azurerm_role_definition" "vm_roles" {
  for_each = contains(var.mdc_plans_list, "VirtualMachines") ? local.virtual_machine_roles : {}

  name  = each.value.name
  scope = data.azurerm_subscription.current.id
}

resource "azurerm_role_assignment" "va_auto_provisioning_vm_role" {
  for_each = contains(var.mdc_plans_list, "VirtualMachines") ? local.virtual_machine_roles : {}

  principal_id       = azurerm_subscription_policy_assignment.vm[each.value.policy].identity[0].principal_id
  scope              = data.azurerm_subscription.current.id
  role_definition_id = data.azurerm_role_definition.vm_roles[each.key].id
}