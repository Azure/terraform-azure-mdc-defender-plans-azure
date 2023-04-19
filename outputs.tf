output "plans_details" {
  description = "All plans details"
  value = {
    for name, pricing in azurerm_security_center_subscription_pricing.asc_plans : name => {
      id      = pricing.id
      status  = pricing.tier == "Standard"
      subplan = pricing.subplan
    }
  }
}

output "subscription_pricing_id" {
  description = "The subscription pricing ID"
  value       = { for plan, pricing in azurerm_security_center_subscription_pricing.asc_plans : plan => pricing.id }
}