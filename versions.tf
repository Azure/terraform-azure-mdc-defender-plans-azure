terraform {
  required_version = ">= 1.3"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.47, < 4.0"
    }
    modtm = {
      source  = "Azure/modtm"
      version = ">= 0.1.7, < 1.0"
    }
  }
}
