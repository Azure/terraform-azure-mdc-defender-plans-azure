module "mdc_plans_enable" {
  source           = "../.."
  mdc_plans_list   = var.mdc_plans_list
  subplans         = var.subplans
  enable_telemetry = var.enable_telemetry
}
