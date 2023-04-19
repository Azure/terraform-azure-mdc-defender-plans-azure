data "azurerm_subscriptions" "available" {}

locals {
  list_of_subscriptions = data.azurerm_subscriptions.available.subscriptions[*].subscription_id
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
