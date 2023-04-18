data "azurerm_management_group" "mgroup" {
  name = var.management_group_id # This is the ID of the management group
}

locals {
  list_of_subscriptions = data.azurerm_management_group.mgroup.subscription_ids
}

resource "local_file" "generate_main_terraform_file" {
  filename = "${path.module}/output/main.tf"
  content = templatefile("resolv.conf.tftpl", {
    list_of_subscriptions = local.list_of_subscriptions
    status                = var.status
    mdc_plans_list        = jsonencode(var.mdc_plans_list)
    subplans              = jsonencode(var.subplans)
  })
}
