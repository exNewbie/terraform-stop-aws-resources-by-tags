resource "aws_iam_role" "StopResources" {
  name = "StopResources-${random_pet.name-suffix.id}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "StopResources-Attach-ResourceGroupsandTagEditorReadOnlyAccess" {
  role       = "${aws_iam_role.StopResources.name}"
  policy_arn = "arn:aws:iam::aws:policy/ResourceGroupsandTagEditorReadOnlyAccess"
}

resource "aws_iam_role_policy_attachment" "StopResources-Attach-AWSLambdaBasicExecutionRole" {
  role       = "${aws_iam_role.StopResources.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy" "StopResources-Attach-EC2-Instances" {
  name = "EC2-Instances"
  role = "${aws_iam_role.StopResources.id}"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": {
        "Effect": "Allow",
        "Action": [
            "ec2:describeInstances",
            "ec2:Stop*"
        ],
        "Resource": "*"
    }
}
EOF
}

resource "aws_iam_role_policy" "StopResources-Attach-RDS" {
  name = "RDS"
  role = "${aws_iam_role.StopResources.id}"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "rds:Describe*",
                "rds:Stop*"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}

#######################################################################################################################

resource "aws_iam_role" "StartResources" {
  name = "StartResources-${random_pet.name-suffix.id}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "StartResources-Attach-ResourceGroupsandTagEditorReadOnlyAccess" {
  role       = "${aws_iam_role.StartResources.name}"
  policy_arn = "arn:aws:iam::aws:policy/ResourceGroupsandTagEditorReadOnlyAccess"
}

resource "aws_iam_role_policy_attachment" "StartResources-Attach-AWSLambdaBasicExecutionRole" {
  role       = "${aws_iam_role.StartResources.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy" "StartResources-Attach-EC2-Instances" {
  name = "EC2-Instances"
  role = "${aws_iam_role.StartResources.id}"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": {
        "Effect": "Allow",
        "Action": [
            "ec2:DescribeInstances",
            "ec2:Start*"
        ],
        "Resource": "*"
    }
}
EOF
}

resource "aws_iam_role_policy" "StartResources-Attach-RDS" {
  name = "RDS"
  role = "${aws_iam_role.StartResources.id}"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "rds:Describe*",
                "rds:Start*"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}
