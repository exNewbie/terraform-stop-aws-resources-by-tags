### Variables ###

variable "cloudwatch_event_target_input" {
  default     = "ap-southeast-2"
  description = "JSON input"
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
