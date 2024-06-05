<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.2.0 |
| aws | >= 4.0, < 6.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| cur\_destination | github.com/aws-samples/aws-cudos-framework-deployment//terraform-modules/cur-setup-destination | 0.3.4 |
| cur\_source | github.com/aws-samples/aws-cudos-framework-deployment//terraform-modules/cur-setup-source | 0.3.4 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create\_cur | Whether to create a local CUR in the destination account or not. Set this to true if the destination account is NOT covered in the CUR of the source accounts.  Set to true when installing the dashboards in the Management/Payer account. | `bool` | `false` | no |
| cur\_name\_suffix | Suffix to append to the CUR name. Default is 'cur' | `string` | `null` | no |
| resource\_prefix | Prefix used for all named resources, including the S3 Bucket | `string` | `null` | no |
| source\_account\_ids | List of all source accounts that will replicate CUR Data. Ex:  [12345678912,98745612312,...] (fill only on Destination Account) | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| destination\_account\_cur\_bucket\_arn | ARN of the S3 Bucket where the Cost and Usage Report is delivered |
| destination\_account\_cur\_bucket\_name | Name of the S3 Bucket where the Cost and Usage Report is delivered |
| destination\_account\_cur\_report\_arn | ARN of the Cost and Usage Report |
| source\_account\_cur\_bucket\_arn | ARN of the S3 Bucket where the Cost and Usage Report is delivered |
| source\_account\_cur\_bucket\_name | Name of the S3 Bucket where the Cost and Usage Report is delivered |
| source\_account\_cur\_report\_arn | ARN of the Cost and Usage Report |
| source\_account\_replication\_role\_arn | ARN of the IAM role created for S3 replication |
| source\_account\_replication\_role\_name | ARN of the IAM role created for S3 replication |
<!-- END_TF_DOCS -->