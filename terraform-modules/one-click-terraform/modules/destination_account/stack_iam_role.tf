data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["glue.amazonaws.com"]
    }
  }
}

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


data "aws_iam_role" "CidCURCrawlerRole" {
  name = "*CidCloudCidCURCrawlerRole*"

  depends_on = [module.cid_dashboards, module.cur_destination]
}

resource "aws_iam_policy" "stack_iam_policy" {
  name   = "StackIAMPolicy"
  policy = data.aws_iam_policy_document.stack_policy_body.json
}

resource "aws_iam_role_policy_attachment" "stack_iam_policy_attachment" {
  role       = data.aws_iam_role.CidCURCrawlerRole.name
  policy_arn = aws_iam_policy.stack_iam_policy.arn

  depends_on = [module.cid_dashboards, module.cur_destination]
}