locals {
  log_analytics_policies = {
    mdc-log-analytics-arc1-autoprovisioning = {
      definition_display_name = "[Preview]: Configure Azure Arc-enabled Windows machines with Log Analytics agents connected to default Log Analytics workspace"
    }
    mdc-log-analytics-arc2-autoprovisioning = {
      definition_display_name = "[Preview]: Configure Azure Arc-enabled Linux machines with Log Analytics agents connected to default Log Analytics workspace"
    }
  }
  log_analytics_roles = {
    sql-server-virtual-machines-arc1-role-1 = {
      name   = "Contributor"
      policy = "mdc-log-analytics-arc1-autoprovisioning"
    }
    sql-server-virtual-machines-arc2-role-1 = {
      name   = "Contributor"
      policy = "mdc-log-analytics-arc2-autoprovisioning"
    }
  }
  sql_server_virtual_machines_enabled = contains(local.final_plans_list, "SqlServerVirtualMachines") && !contains(var.mdc_plans_list, "VirtualMachines")
}

# Enabling extension - Log Analytics for arc
data "azurerm_policy_definition" "la_policies" {
  for_each = local.sql_server_virtual_machines_enabled ? local.log_analytics_policies : {}

  display_name = each.value.definition_display_name
}

resource "azurerm_subscription_policy_assignment" "sql" {
  for_each = local.sql_server_virtual_machines_enabled ? local.log_analytics_policies : {}

  name                 = each.key
  policy_definition_id = data.azurerm_policy_definition.la_policies[each.key].id
  subscription_id      = data.azurerm_subscription.current.id
  display_name         = each.value.definition_display_name
  location             = var.location

  identity {
    type = "SystemAssigned"
  }

  depends_on = [
    azurerm_security_center_subscription_pricing.asc_plans["SqlServerVirtualMachines"]
  ]
}

# Enabling extension - Log Analytics for vm
resource "azurerm_security_center_auto_provisioning" "la_auto_provisioning" {
  count = local.sql_server_virtual_machines_enabled ? 1 : 0

  auto_provision = "On"

  depends_on = [
    azurerm_security_center_subscription_pricing.asc_plans["SqlServerVirtualMachines"]
  ]
}

# Enabling Log Analytics Roles
data "azurerm_role_definition" "la_roles" {
  for_each = local.sql_server_virtual_machines_enabled ? local.log_analytics_roles : {}

  name = each.value.name
}

resource "azurerm_role_assignment" "va_auto_provisioning_la_role" {
  for_each = local.sql_server_virtual_machines_enabled ? local.log_analytics_roles : {}

  principal_id       = azurerm_subscription_policy_assignment.sql[each.value.policy].identity[0].principal_id
  scope              = data.azurerm_subscription.current.id
  role_definition_id = data.azurerm_role_definition.la_roles[each.key].id
}