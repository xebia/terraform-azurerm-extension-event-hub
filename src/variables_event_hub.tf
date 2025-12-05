variable "event_hub_namespace_id" {
  description = "The ID of the Event Hub namespace."
  type        = string
}

variable "name" {
  description = "The name of the Event Hub."
  type        = string
}

variable "message_retention" {
  description = "The message retention period for the Event Hub."
  type        = number
}

variable "partition_count" {
  description = "The number of partitions for the Event Hub."
  type        = number
}
