# Configure exactly one destination account
module "cur_destination" {
  source = "github.com/aws-samples/aws-cudos-framework-deployment//terraform-modules/cur-setup-destination?ref=0.3.4"

  source_account_ids = var.source_account_ids
  create_cur         = var.create_cur # Set to true to create an additional CUR in the aggregation account
  # cur_name_suffix    = var.cur_name_suffix
  # resource_prefix    = var.resource_prefix

  # Provider alias for us-east-1 must be passed explicitly (required for CUR setup)
  # Optionally, you may pass the default aws provider explicitly as well
  providers = {
    aws.useast1 = aws.useast1
  }
}