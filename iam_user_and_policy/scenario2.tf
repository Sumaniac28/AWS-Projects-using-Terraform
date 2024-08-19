resource "aws_iam_policy" "dev_group_policy" {
  name        = "dev-policy"
  description = "Allow read only access to S3 bucket"
  policy = jsondecode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "s3:GetObject",
          "s3:ListBucket"
        ],
        "Resource" : "*"
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "dev_group_policy_attachment" {
  policy_arn = aws_iam_policy.dev_group_policy.arn
  group      = aws_iam_group.dev_group.name
}