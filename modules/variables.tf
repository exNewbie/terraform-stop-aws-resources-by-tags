### Variables ###

variable "cloudwatch_event_target_input" {
  default     = "ap-southeast-2"
  description = "JSON input"
}

### Data ###

data "archive_file" "StopResourcesByTags" {
  type        = "zip"
  source_file = "${path.module}/scripts/StopResourcesByTags.py"
  output_path = "${path.module}/scripts/StopResourcesByTags.zip"
}

### Resources ###

resource "random_pet" "name-suffix" {
  length = 1
}
