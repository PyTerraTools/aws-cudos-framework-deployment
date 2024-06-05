# Configure one or more source (payer) accounts
module "cur_source" {
  source = "github.com/aws-samples/aws-cudos-framework-deployment//terraform-modules/cur-setup-source?ref=0.3.4"

  destination_bucket_arn = module.cur_destination.cur_bucket_arn
  # cur_name_suffix        = var.cur_name_suffix
  # resource_prefix        = var.resource_prefix

  # Provider alias for us-east-1 must be passed explicitly (required for CUR setup)
  # Optionally, you may pass the default aws provider explicitly as well
  providers = {
    aws.useast1 = aws.useast1
  }
}
