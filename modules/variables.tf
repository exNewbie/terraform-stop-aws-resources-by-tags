### Variables ###

variable "cloudwatch_event_target_input" {
  default     = "ap-southeast-2"
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

### Data ###

data "archive_file" "StopResourcesByTags" {
  type        = "zip"
  source_dir  = "${path.module}/scripts/StopResourcesByTags"
  output_path = "${path.module}/scripts/StopResourcesByTags.zip"
}

data "archive_file" "StartResourcesByTags" {
  type        = "zip"
  source_dir  = "${path.module}/scripts/StartResourcesByTags"
  output_path = "${path.module}/scripts/StartResourcesByTags.zip"
}

### Resources ###

resource "random_pet" "name-suffix" {
  length = 1
}
