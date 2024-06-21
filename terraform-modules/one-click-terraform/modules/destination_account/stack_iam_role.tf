locals {
  stack_policy_body = <<EOF
{
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:us-east-1:${data.aws_caller_identity.current.account_id}:log-group:/aws-glue/crawlers:*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "glue:GetDatabase"
      ],
      "Resource": "arn:aws:glue:us-east-1:${data.aws_caller_identity.current.account_id}:catalog/database/cid_cur"
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:GetObject",
        "s3:ListBucket"
      ],
      "Resource": [
        "arn:aws:s3:::cid-${data.aws_caller_identity.current.account_id}-shared",
        "arn:aws:s3:::cid-${data.aws_caller_identity.current.account_id}-shared/cur/*"
      ]
    }
  ]
}
EOF
}