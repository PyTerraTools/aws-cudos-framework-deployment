# One-Click Cloud Intelligence Dashboards Terraform Module

This module simplifies the process of creating CUDOS, KPI, CID, Compute Optimizer, and Trusted Advisor Organizational (TAO) Cloud Intelligence Dashboards outlined on https://catalog.workshops.aws/awscid/en-US using a Terraform workflow. It automates the manual steps for creating an Amazon QuickSight account, as well providing the option to disabling termination protection for the QuickSight account to enable deletion via Terraform and adding permissions to datasets for new users using Lambda Functions. 

## How to setup the dashboards
### Management ( Payer/Source)  Account
This should be the organization management account from which the Cost and Usage Reports (CUR) will be generated and retrieved.

Create a Terraform module with a configuration similar to the following: 

```
module "cid-source" {
  source             = "./aws-cudos-framework-deployment/terraform-modules/one-click-terraform/modules/source_account"
  source_account_ids = [data.aws_caller_identity.current.account_id]
  create_cur         = false
  providers = {
    aws.useast1     = aws.use1
    aws.src         = aws.use1
    aws.dst         = aws.use1
    aws.dst_useast1 = aws.use1
    aws.src_useast1 = aws.use1
  }
}
```

### Collection (Destination) Account
This is a dedicated account in which the Cloud Intelligence Dashboards will be created. It is possible, though not recommended, to create both the CUR reports and dashboards in the same (management) account.

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

No modules.

## Resources

No resources.

## Inputs

No inputs.

## Outputs

No outputs.
<!-- END_TF_DOCS -->