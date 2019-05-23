terraform {
  backend "s3" {
    encrypt = true

    bucket         = "minergroup-terraform-state-store"
    dynamodb_table = "terraform-state-lock"

    region = "ap-southeast-2"
    key    = "stop-resources/terraform-state-lock"
  }
}

locals {
  workspace = "${terraform.workspace == "default" ? "lab" : terraform.workspace}"
}

provider "aws" {
  alias   = "default"
  region  = "ap-southeast-2"
  profile = "${local.workspace}"
}

module "stop-resources" {
  source = "./modules"

  providers = {
    "aws" = "aws.default"
  }

  cloudwatch_event_target_input = "${var.cloudwatch_event_target_input}"
}
