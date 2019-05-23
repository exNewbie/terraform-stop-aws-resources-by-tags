resource "aws_cloudwatch_event_rule" "StopResources" {
  name                = "StopResources-${random_pet.name-suffix.id}"
  schedule_expression = "cron(00 09 * * ? *)"
}

resource "aws_cloudwatch_event_target" "StopResources-Target" {
  rule  = "${aws_cloudwatch_event_rule.StopResources.name}"
  arn   = "${aws_lambda_function.StopResourcesByTags.arn}"
  input = "${var.cloudwatch_event_target_input}"
}

##############################################################################

resource "aws_cloudwatch_event_rule" "StartResources" {
  name                = "StartResources-${random_pet.name-suffix.id}"
  schedule_expression = "cron(00 19 * * ? *)"
}

resource "aws_cloudwatch_event_target" "StartResources-Target" {
  rule  = "${aws_cloudwatch_event_rule.StartResources.name}"
  arn   = "${aws_lambda_function.StartResourcesByTags.arn}"
  input = "${var.cloudwatch_event_target_input}"
}
