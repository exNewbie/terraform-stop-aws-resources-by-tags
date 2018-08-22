resource "aws_cloudwatch_event_rule" "StopResources" {
  name                = "StopResources-${random_pet.name-suffix.id}"
  schedule_expression = "cron(00 08 * * ? *)"
}

resource "aws_cloudwatch_event_target" "StopResources-Target" {
  rule  = "${aws_cloudwatch_event_rule.StopResources.name}"
  arn   = "${aws_lambda_function.StopResourcesByTags.arn}"
  input = "${var.cloudwatch_event_target_input}"
}
