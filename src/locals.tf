locals {
  eventhubs_map = { for eh in var.eventhubs : eh.name => eh }
}
