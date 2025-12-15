resource "azurerm_eventhub" "eventhub" {
  provider = azurerm.eventhub

  for_each = { for eh in var.eventhubs : eh.name => eh }

  namespace_id      = var.event_hub_namespace_id
  name              = each.value.name
  message_retention = each.value.message_retention_in_days
  partition_count   = each.value.partition_count
  status            = each.value.status
}

resource "azurerm_role_assignment" "sp_event_hub_uac" {
  for_each = azurerm_eventhub.eventhub

  principal_id         = var.service_principal_object_id
  role_definition_name = "User Access Administrator"
  scope                = each.value.id
}

resource "azurerm_role_assignment" "owner_event_hub_group_data_owner" {
  for_each = azurerm_eventhub.eventhub

  principal_id         = var.owner_group_id
  role_definition_name = "Azure Event Hubs Data Owner"
  scope                = each.value.id
}

resource "azurerm_role_assignment" "owner_group_event_hub_owner" {
  for_each = azurerm_eventhub.eventhub

  principal_id         = var.owner_group_id
  role_definition_name = "Owner"
  scope                = each.value.id
}

resource "azurerm_role_assignment" "contributor_group_event_hub_contributor" {
  for_each = azurerm_eventhub.eventhub

  principal_id         = var.contributor_group_id
  role_definition_name = "Contributor"
  scope                = each.value.id
}

resource "azurerm_role_assignment" "reader_group_event_hub_reader" {
  for_each = azurerm_eventhub.eventhub

  principal_id         = var.reader_group_id
  role_definition_name = "Reader"
  scope                = each.value.id
}
