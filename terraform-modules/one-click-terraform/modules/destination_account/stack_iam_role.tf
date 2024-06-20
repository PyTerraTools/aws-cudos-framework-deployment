data "aws_iam_policy_document" "stack_iam_policy_body" {
  statement {
    actions = [
      "glue:GetDatabase",
      "logs:PutLogEvents",
      "s3:Get*"
    ]
    resources = ["*"]
  }
}
