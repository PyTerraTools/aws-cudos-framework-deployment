<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.2 |
| archive | ~> 2.4 |
| aws | < 6.0 |
| time |  ~> 0.10 |

## Providers

| Name | Version |
|------|---------|
| archive | ~> 2.4 |
| aws | < 6.0 |
| time |  ~> 0.10 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| cid\_dashboards | github.com/aws-samples/aws-cudos-framework-deployment//terraform-modules/cid-dashboards | 0.3.4 |
| cur\_destination | github.com/aws-samples/aws-cudos-framework-deployment//terraform-modules/cur-setup-destination | 0.3.4 |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_event_rule.add_quicksight_dataset_permissions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_target.add_quicksight_dataset_permissions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |
| [aws_iam_policy.quicksight_dataset_permissions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.s3_get_object](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.add_quicksight_dataset_permissions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.cid_stack_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.add_quicksight_dataset_permissions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.s3_get_object_attach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_lambda_function.add_quicksight_dataset_permissions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_lambda_function.disable_quicksight_account_termination_protection](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_lambda_invocation.add_quicksight_dataset_permissions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_invocation) | resource |
| [aws_lambda_invocation.disable_quicksight_account_termination_protection](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_invocation) | resource |
| [aws_quicksight_account_subscription.cid_dashboards](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/quicksight_account_subscription) | resource |
| [aws_quicksight_user.cid_dashboards](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/quicksight_user) | resource |
| [aws_s3_bucket.template_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [time_sleep.wait](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [time_sleep.wait_60](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [archive_file.add_quicksight_dataset_permissions](https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/file) | data source |
| [archive_file.disable_quicksight_account_termination_protection](https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/file) | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.assume_lambda_service_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.cid_stack_assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.quicksight_dataset_permissions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.s3_get_object](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| add\_quicksight\_data\_set\_permissions\_function\_name | Name of the Lambda function to add QuickSight data set permissions to new users | `string` | `"CidAddQuickSightDataSetPermissionsToUsers"` | no |
| add\_quicksight\_dataset\_permissions\_lambda\_\_schedule\_expression | The schedule expression for the Lambda function | `string` | `"cron(0 6-18 ? * MON-FRI *)"` | no |
| add\_quicksight\_dataset\_permissions\_role\_name | The name of the IAM role | `string` | `"CidAddQuickSightDataSetPermissionsToUsersRole"` | no |
| add\_quicksight\_dataset\_permissions\_rule\_name | The name of the CloudWatch event rule | `string` | `"CidAddQuickSightDataSetPermissionsToUsersRule"` | no |
| create\_cur | Whether to create a local CUR in the destination account or not. Set this to true if the destination account is NOT covered in the CUR of the source accounts. Setting this to true will create a new CUR in the destination/aggregation account. | `bool` | `false` | no |
| cur\_bucket\_path | Path to Cost and Usage report. Leave as default is if CUR was created with CloudFormation (cur-aggregation.yaml). If it was a manually created CUR, the path entered below must be for the directory that contains the years partition (s3://curbucketname/prefix/curname/curname/). | `string` | `null` | no |
| cur\_name\_suffix | Suffix to append to the CUR name. Default is 'cur' | `string` | `null` | no |
| data\_buckets\_kms\_key\_arns | ARNs of KMS Keys for data bucket (comma separated, no spaces). Keep empty if data Buckets are not Encrypted with KMS. You can also set it to '*' to grant decrypt permission for all the keys. | `string` | `null` | no |
| deploy\_compute\_optimizer\_dashboard | Deploy Compute Optimizer Dashboard | `string` | `"no"` | no |
| deploy\_cost\_intelligence\_dashboard | Deploy CostIntelligenceDashboard | `string` | `"yes"` | no |
| deploy\_cudos\_dashboard | CUDOS Dashboard v4 - Deprecated [set 'no' to delete] | `string` | `"no"` | no |
| deploy\_cudos\_v5\_dashboard | Deploy CUDOS Dashboard v5 | `string` | `"yes"` | no |
| deploy\_kpi\_dashboard | Deploy KPI Dashboard | `string` | `"yes"` | no |
| deploy\_tao\_dashboard | Deploy TAO Dashboard | `string` | `"no"` | no |
| disable\_quicksight\_termination\_protection\_function\_name | Name of the Lambda function to disable QuickSight account termination protection | `string` | `"CidDisableQuickSightAccountTerminationProtection"` | no |
| enable\_add\_quicksight\_data\_set\_permissions\_lambda | Enable the Lambda function to add QuickSight data set permissions to new users | `bool` | `false` | no |
| enable\_quicksight\_termination\_protection\_lambda | Enable the Lambda function to disable QuickSight account termination protection | `bool` | `false` | no |
| lake\_formation\_enabled | I have LakeFormation permission model in place for this account & my cfn deployment credentials have administrative rights on LakeFormation | `string` | `"no"` | no |
| lambda\_function\_handler | The function entrypoint in your code. | `string` | `"lambda_function.lambda_handler"` | no |
| lambda\_function\_runtime | The runtime environment for the Lambda function. | `string` | `"python3.12"` | no |
| lambda\_function\_timeout | The amount of time your Lambda function has to run in seconds. | `number` | `900` | no |
| lambda\_powertools\_version | Version of Lambda Powertools | `string` | `"PythonV2:68"` | no |
| optimization\_data\_collection\_bucket\_path | Path to Optimization Data Collection S3 bucket | `string` | `null` | no |
| prerequisites\_quick\_sight | I have enabled QuickSight Enterprise Edition AND I have a SPICE capacity in the current region. | `string` | `"yes"` | no |
| prerequisites\_quick\_sight\_permissions | I understand that I need to manually give Permission to QuickSight to access CUR bucket and Query results bucket. Then manually refresh datasets after deploying this CFN. | `string` | `"yes"` | no |
| primary\_tag\_name | Choose a tag name. Currently used only in Compute Optimizer dashboard. | `string` | `null` | no |
| quick\_sight\_data\_set\_refresh\_schedule | QuickSight DataSet Refresh Schedule. Must be a valid cron or empty. If empty refresh will be disabled. | `string` | `null` | no |
| quick\_sight\_data\_source\_role\_name | IAM Role Name to be used on QuickSight Datasource Creation (if not provided, the default QuickSight Role will be used). | `string` | `"CidQuickSightDataSourceRole"` | no |
| quicksight\_account\_contact\_number | The contact number of the QuickSight account. Required when the edition is 'ENTERPRISE\_AND\_Q' | `string` | `null` | no |
| quicksight\_account\_edition | The edition of the QuickSight account | `string` | `"ENTERPRISE"` | no |
| quicksight\_account\_first\_name | The first name of the QuickSight account. Required when the edition is 'ENTERPRISE\_AND\_Q' | `string` | `null` | no |
| quicksight\_account\_last\_name | The last name of the QuickSight account. Required when the edition is 'ENTERPRISE\_AND\_Q' | `string` | `null` | no |
| quicksight\_active\_directory\_admin\_group | The name of the Active Directory admin group | `list(string)` | `null` | no |
| quicksight\_active\_directory\_author\_group | The name of the Active Directory author group | `list(string)` | `null` | no |
| quicksight\_active\_directory\_id | The ID of the Active Directory | `string` | `null` | no |
| quicksight\_active\_directory\_name | The name of the Active Directory | `string` | `null` | no |
| quicksight\_active\_directory\_reader\_group | The name of the Active Directory reader group | `list(string)` | `null` | no |
| quicksight\_active\_directory\_realm | The realm of the Active Directory | `string` | `null` | no |
| quicksight\_authentication\_method | Method to authenticate your Amazon QuickSight account | `string` | `"IAM_AND_QUICKSIGHT"` | no |
| quicksight\_enterprise\_and\_q\_email | The email address of the QuickSight account. Required when the edition is 'ENTERPRISE\_AND\_Q' | `string` | `null` | no |
| quicksight\_lambda\_role\_policy\_name | The name of the IAM policy | `string` | `"CidQuickSightDataSetPermissions"` | no |
| quicksight\_lambda\_role\_policy\_sid | The SID of the IAM policy | `string` | `"CidQuickSightDataSetPermissions"` | no |
| quicksight\_notifications\_email | The email of the QuickSight user that will be created in the destination account (where the Cloud Intelligence Dashboard will be installed) | `string` | n/a | yes |
| quicksight\_user | An xisting QuickSight user | `string` | `null` | no |
| quicksight\_user\_email | The email of the QuickSight user | `string` | n/a | yes |
| quicksight\_user\_iam\_arn | The ARN of the IAM user. Required if identity type is IAM. | `string` | `null` | no |
| quicksight\_user\_identity\_type | The identity type of the QuickSight user | `string` | `"QUICKSIGHT"` | no |
| quicksight\_user\_name | The name of the QuickSight user | `string` | `"QuickSightAdmin"` | no |
| quicksight\_user\_namespace | The namespace of the QuickSight user | `string` | `"default"` | no |
| quicksight\_user\_role | The role of the QuickSight user | `string` | `"ADMIN"` | no |
| resource\_prefix | Prefix used for all named resources, including the S3 Bucket | `string` | `null` | no |
| secondary\_tag\_name | Choose a tag name. Currently used only in Compute Optimizer dashboard. | `string` | `null` | no |
| stack\_iam\_role | The IAM role that will be used by the Cloud Intelligence Dashboards stack | `string` | `null` | no |
| stack\_name | CloudFormation stack name for Cloud Intelligence Dashboards deployment | `string` | `"Cloud-Intelligence-Dashboards"` | no |
| stack\_policy\_body | String containing the stack policy body. Conflicts with stack\_policy\_url. | `string` | `null` | no |
| test\_suffix | A random suffix to append to the resource names for testing purposes | `string` | `""` | no |
| time\_sleep\_create\_duration | Time to sleep before creating QuickSight dashboard and user | `string` | `"10s"` | no |

## Outputs

| Name | Description |
|------|-------------|
| cid\_dashboards\_stack\_outputs | CloudFormation stack outputs (map of strings) |
| destination\_account\_cur\_bucket\_arn | ARN of the S3 Bucket where the Cost and Usage Report is delivered |
| destination\_account\_cur\_bucket\_name | Name of the S3 Bucket where the Cost and Usage Report is delivered |
| destination\_account\_cur\_report\_arn | ARN of the Cost and Usage Report |
| disable\_quicksight\_account\_termination\_protection\_result | n/a |
| quicksight\_account\_status | The status of Amazon Quicksight account's subscription |
<!-- END_TF_DOCS -->