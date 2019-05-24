terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "#Your Organization#"

    workspaces {
      prefix = "start-stop-resources-"
    }
  }
}

provider "aws" {
  alias  = "default"
  region = "ap-southeast-2"
}

module "start-stop-resources" {
  source = "./modules"

  providers = {
    "aws" = "aws.default"
  }

  cloudwatch_event_target_input = "${var.cloudwatch_event_target_input}"
  schedule_stop_resources       = "${var.schedule_stop_resources}"
  schedule_start_resources      = "${var.schedule_start_resources}"
}
