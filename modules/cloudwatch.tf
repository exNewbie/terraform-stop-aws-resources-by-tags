resource "aws_cloudwatch_event_rule" "StopResources" {
  name                = "StopResources-${random_pet.name-suffix.id}"
  schedule_expression = "${var.schedule_stop_resources}"
}

resource "aws_cloudwatch_event_target" "StopResources-Target" {
  rule  = "${aws_cloudwatch_event_rule.StopResources.name}"
  arn   = "${aws_lambda_function.StopResourcesByTags.arn}"
  input = "${var.cloudwatch_event_target_input}"
}

##############################################################################

resource "aws_cloudwatch_event_rule" "StartResources" {
  name                = "StartResources-${random_pet.name-suffix.id}"
  schedule_expression = "${var.schedule_start_resources}"
}

resource "aws_cloudwatch_event_target" "StartResources-Target" {
  rule  = "${aws_cloudwatch_event_rule.StartResources.name}"
  arn   = "${aws_lambda_function.StartResourcesByTags.arn}"
  input = "${var.cloudwatch_event_target_input}"
}
