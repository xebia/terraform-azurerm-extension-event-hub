variable "event_hub_namespace_id" {
  description = "The ID of the Event Hub namespace."
  type        = string
}

variable "eventhubs" {
  description = "A list of Event Hubs to create within the namespace."
  type = list(object({
    name                      = string
    message_retention_in_days = optional(number, 1)
    partition_count           = optional(number, 2)
    status                    = optional(string, "Active")
  }))
  default = []
  validation {
    condition     = alltrue([for eh in var.eventhubs : contains(["Active", "Disabled", "SendDisabled"], eh.status)])
    error_message = "Each Event Hub status must be one of the following: Active, Disabled, SendDisabled."
  }
}
