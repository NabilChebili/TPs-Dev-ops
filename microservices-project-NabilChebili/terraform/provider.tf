terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=2.86.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "rg-nabil.chebili"
    storage_account_name = "nabilchebili"
    container_name       = "tfstatedevops"
    key                  = "tfstatedevops.tfstate"
  }
}

provider "azurerm" {
  features {}

  subscription_id = "001ba5c0-9b7d-4eac-8565-1bc64252d3a8"
  tenant_id = "c8709a2a-70b6-49b5-bdd5-6868b476da85"
  skip_provider_registration = true
}