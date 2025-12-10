terraform {
  required_version = "~> 1.1, <= 1.9.5"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.14.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "3.0.2"
    }
  }
}

provider "azurerm" {
  alias = "eventhub"
  features {}
}

provider "azurerm" {
  features {}
}
