terraform {
  backend "azurerm" {
    resource_group_name  = "backend_rg"
    storage_account_name = "backendstgac"
    container_name       = "stgcontaioner"
    key                  = "terraform.tfstate"
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "5.6.0"
    }
  }
}

provider "azurerm" {
  features {}
}