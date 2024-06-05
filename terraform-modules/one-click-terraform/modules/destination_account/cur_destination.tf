# https://github.com/aws-samples/aws-cudos-framework-deployment/tree/main/terraform-modules/cur-setup-destination'
module "cur_destination" {
  count = var.create_cur ? 1 : 0

  source = "github.com/aws-samples/aws-cudos-framework-deployment//terraform-modules/cur-setup-destination?ref=0.3.4"

  source_account_ids = [data.aws_caller_identity.current.account_id]
  # Set to true to create an additional CUR in the aggregation account
  create_cur = var.create_cur

  # Provider alias for us-east-1 must be passed explicitly (required for CUR setup)
  providers = {
    aws.useast1 = aws.useast1
  }

}