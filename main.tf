provider "aws" {
  alias  = "default"
  region = "ap-southeast-2"
}

module "stop-resources" {
  source = "./modules"

  providers = {
    "aws" = "aws.default"
  }

  cloudwatch_event_target_input = "${var.cloudwatch_event_target_input}"
}
