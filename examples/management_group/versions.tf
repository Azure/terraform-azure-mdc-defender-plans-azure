terraform {
  required_version = ">= 1.2"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.7.0, < 4.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.3.0"
    }
  }
}

provider "azurerm" {
  features {}
}
