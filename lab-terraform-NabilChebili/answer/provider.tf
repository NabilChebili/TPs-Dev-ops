terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=2.79.1"
    }
  }
}

provider "azurerm" {
  features {}

  subscription_id = "001ba5c0-9b7d-4eac-8565-1bc64252d3a8"
  tenant_id = "c8709a2a-70b6-49b5-bdd5-6868b476da85"
  skip_provider_registration = true
}