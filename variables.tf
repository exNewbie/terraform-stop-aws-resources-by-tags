### Variables ###

variable "cloudwatch_event_target_input" {
  description = "JSON input"
}

variable "schedule_start_resources" {
  type        = "string"
  description = "Time to start resources"
}

variable "schedule_stop_resources" {
  type        = "string"
  description = "Time to stop resources"
}
