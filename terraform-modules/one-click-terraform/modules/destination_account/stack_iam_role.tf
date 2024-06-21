# data "aws_iam_policy_document" "stack_iam_role" {
#   statement {
#     actions = [
#       "glue:GetDatabase",
#       "logs:PutLogEvents",
#       "s3:Get*"
#     ]
#     resources = ["*"]
#   }
# }

# resource "aws_iam_role" "stack_iam_role" {
#   name               = "CidCloudFormationStackRole"
#   assume_role_policy = data.aws_iam_policy_document.cid_stack_assume_role_policy.json
# }