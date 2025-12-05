resource "azurerm_resource_group" "rg" {
  name     = "rg-event-hub"
  location = "westeurope"
}

resource "azuread_application" "sp_app" {
  display_name = "sp_app"
}

resource "azuread_service_principal" "sp" {
  client_id = azuread_application.sp_app.client_id
}

resource "azuread_group" "owner_group" {
  display_name     = "Owner Group"
  security_enabled = true
}

resource "azuread_group" "contributor_group" {
  display_name     = "Contributor Group"
  security_enabled = true
}

resource "azuread_group" "reader_group" {
  display_name     = "Reader Group"
  security_enabled = true
}

resource "azurerm_eventhub_namespace" "namespace" {
  provider = azurerm.eventhub

  name                = "namespace"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Standard"
}

module "defaults" {
  source = "../../src"
  providers = {
    azurerm          = azurerm
    azurerm.eventhub = azurerm.eventhub
  }

  # global
  service_principal_object_id = azuread_service_principal.sp.object_id
  owner_group_id              = azuread_group.owner_group.object_id
  contributor_group_id        = azuread_group.contributor_group.object_id
  reader_group_id             = azuread_group.reader_group.object_id

  # event hub
  event_hub_namespace_id = azurerm_eventhub_namespace.namespace.id
  name                   = "event-hub"
  partition_count        = 2
  message_retention      = 1
}
