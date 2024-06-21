data "aws_iam_policy_document" "stack_policy_body" {
  statement {
    actions = [
      "logs:PutLogEvents"
    ]
    resources = ["arn:aws:logs:us-east-1:${data.aws_caller_identity.current.account_id}:log-group:/aws-glue/crawlers:*"]
  }

  statement {
    actions = [
      "glue:GetDatabase"
    ]
    resources = ["arn:aws:glue:us-east-1:${data.aws_caller_identity.current.account_id}:catalog/database/cid_cur"]
  }

  statement {
    actions = [
      "s3:GetObject",
      "s3:ListBucket"
    ]
    resources = [
      "arn:aws:s3:::cid-${data.aws_caller_identity.current.account_id}-shared",
      "arn:aws:s3:::cid-${data.aws_caller_identity.current.account_id}-shared/cur/*"
    ]
  }
}

# resource "aws_iam_role" "stack_iam_role" {
#   name               = "CidCloudFormationStackRole"
#   assume_role_policy = data.aws_iam_policy_document.cid_stack_assume_role_policy.json
# }