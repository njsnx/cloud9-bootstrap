provider "aws" {
  region = var.region
}

resource "aws_iam_user" "deployment-user" {
  name = "cicd-deployment-user"
}

resource "aws_iam_user" "actions-user" {
  name = "cicd-actions-user"
}

resource "aws_iam_access_key" "deployment-access-key" {
  user = aws_iam_user.deployment-user.name
}

resource "aws_iam_access_key" "githubactions-access-key" {
  user = aws_iam_user.actions-user.name
}

resource "aws_iam_user_policy" "actions-policy" {
  name = "test"
  user = aws_iam_user.actions-user.name

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ssm:Get*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_user_policy" "lb_ro" {
  name = "test"
  user = aws_iam_user.deployment-user.name

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_ssm_parameter" "my-deployment-keys" {
  name = "/github-actions/my-deployment-key"
  type = "SecureString"
  value = jsonencode({
    access = aws_iam_access_key.deployment-access-key.id
    secret = aws_iam_access_key.deployment-access-key.secret
  })
}
