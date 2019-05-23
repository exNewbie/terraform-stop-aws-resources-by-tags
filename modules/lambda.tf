resource "aws_lambda_function" "StopResourcesByTags" {
  function_name    = "StopResourcesByTags-${random_pet.name-suffix.id}"
  role             = "${aws_iam_role.StopResources.arn}"
  handler          = "StopResourcesByTags.lambda_handler"
  filename         = "${path.module}/scripts/StopResourcesByTags.zip"
  source_code_hash = "${data.archive_file.StopResourcesByTags.output_base64sha256}"
  runtime          = "python3.6"
  timeout          = "300"
}

resource "aws_lambda_permission" "StopResourcesByTags-CloudWatchRule" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.StopResourcesByTags.function_name}"
  principal     = "events.amazonaws.com"
  source_arn    = "${aws_cloudwatch_event_rule.StopResources.arn}"
}

resource "aws_lambda_function" "StartResourcesByTags" {
  function_name    = "StartResourcesByTags-${random_pet.name-suffix.id}"
  role             = "${aws_iam_role.StartResources.arn}"
  handler          = "StartResourcesByTags.lambda_handler"
  filename         = "${path.module}/scripts/StartResourcesByTags.zip"
  source_code_hash = "${data.archive_file.StartResourcesByTags.output_base64sha256}"
  runtime          = "python3.6"
  timeout          = "300"
}

resource "aws_lambda_permission" "StartResourcesByTags-CloudWatchRule" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.StartResourcesByTags.function_name}"
  principal     = "events.amazonaws.com"
  source_arn    = "${aws_cloudwatch_event_rule.StartResources.arn}"
}
