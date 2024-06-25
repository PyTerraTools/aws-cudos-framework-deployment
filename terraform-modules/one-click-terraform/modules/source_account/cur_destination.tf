module "cur_destination" {
  source = "github.com/aws-samples/aws-cudos-framework-deployment//terraform-modules/cur-setup-destination"

  source_account_ids = var.source_account_ids
  create_cur         = var.create_cur

  providers = {
    aws.useast1 = aws.useast1
  }
}
