module "cur_source" {
  source = "github.com/aws-samples/aws-cudos-framework-deployment//terraform-modules/cur-setup-source"

  destination_bucket_arn = module.cur_destination.cur_bucket_arn

  providers = {
    aws.useast1 = aws.useast1
  }
}
