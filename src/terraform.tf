terraform {
  required_version = "~> 1.1"

  required_providers {
    azurerm = {
      configuration_aliases = [
        azurerm,
        azurerm.eventhub
      ]
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}
