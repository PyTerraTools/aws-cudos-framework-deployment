# variable "source_account_ids" {
#   description = "List of all source accounts that will replicate CUR Data. Ex:  [12345678912,98745612312,...] (fill only on Destination Account)"
#   type        = list(string)
# }

variable "create_cur" {
  description = "Whether to create a local CUR in the destination account or not. Set this to true if the destination account is NOT covered in the CUR of the source accounts. Setting this to true will create a new CUR in the destination/aggregation account."
  type        = bool
  default     = false
}

variable "lambda_function_handler" {
  description = "The function entrypoint in your code."
  type        = string
  default     = "lambda_function.lambda_handler"
}

variable "lambda_function_runtime" {
  description = "The runtime environment for the Lambda function."
  type        = string
  default     = "python3.12"
}

variable "lambda_function_timeout" {
  description = "The amount of time your Lambda function has to run in seconds."
  type        = number
  default     = 900
}

variable "quicksight_notifications_email" {
  description = "The email of the QuickSight user that will be created in the destination account (where the Cloud Intelligence Dashboard will be installed)"
  type        = string
}

variable "cur_name_suffix" {
  description = "Suffix to append to the CUR name. Default is 'cur'"
  type        = string
  default     = null
}

variable "resource_prefix" {
  description = "Prefix used for all named resources, including the S3 Bucket"
  type        = string
  default     = null
}

variable "test_suffix" {
  description = "A random suffix to append to the resource names for testing purposes"
  type        = string
  default     = ""
}

variable "stack_iam_role" {
  description = "The IAM role that will be used by the Cloud Intelligence Dashboards stack"
  type        = string
  default     = null
}

variable "stack_policy_body" {
  description = "String containing the stack policy body. Conflicts with stack_policy_url."
  type        = string
  default     = null
}

variable "stack_name" {
  description = "CloudFormation stack name for Cloud Intelligence Dashboards deployment"
  type        = string
  default     = "Cloud-Intelligence-Dashboards"
}
variable "prerequisites_quick_sight" {
  description = "I have enabled QuickSight Enterprise Edition AND I have a SPICE capacity in the current region."
  type        = string
  default     = "yes"
}

variable "prerequisites_quick_sight_permissions" {
  description = "I understand that I need to manually give Permission to QuickSight to access CUR bucket and Query results bucket. Then manually refresh datasets after deploying this CFN."
  type        = string
  default     = "yes"
}

variable "deploy_cudos_dashboard" {
  description = "CUDOS Dashboard v4 - Deprecated [set 'no' to delete]"
  type        = string
  default     = "no"
}

variable "deploy_cudos_v5_dashboard" {
  description = "Deploy CUDOS Dashboard v5"
  type        = string
  default     = "yes"
}

variable "deploy_cost_intelligence_dashboard" {
  description = "Deploy CostIntelligenceDashboard"
  type        = string
  default     = "yes"
}

variable "deploy_kpi_dashboard" {
  description = "Deploy KPI Dashboard"
  type        = string
  default     = "yes"
}

variable "deploy_tao_dashboard" {
  description = "Deploy TAO Dashboard"
  type        = string
  default     = "no"
}

variable "deploy_compute_optimizer_dashboard" {
  description = "Deploy Compute Optimizer Dashboard"
  type        = string
  default     = "no"
}

variable "data_buckets_kms_key_arns" {
  description = "ARNs of KMS Keys for data bucket (comma separated, no spaces). Keep empty if data Buckets are not Encrypted with KMS. You can also set it to '*' to grant decrypt permission for all the keys."
  type        = string
  default     = null
}

variable "optimization_data_collection_bucket_path" {
  description = "Path to Optimization Data Collection S3 bucket"
  type        = string
  default     = null
}

variable "cur_bucket_path" {
  description = "Path to Cost and Usage report. Leave as default is if CUR was created with CloudFormation (cur-aggregation.yaml). If it was a manually created CUR, the path entered below must be for the directory that contains the years partition (s3://curbucketname/prefix/curname/curname/)."
  type        = string
  default     = null
}

variable "quick_sight_data_set_refresh_schedule" {
  description = "QuickSight DataSet Refresh Schedule. Must be a valid cron or empty. If empty refresh will be disabled."
  type        = string
  default     = null
}

variable "primary_tag_name" {
  description = "Choose a tag name. Currently used only in Compute Optimizer dashboard."
  type        = string
  default     = null
}

variable "secondary_tag_name" {
  description = "Choose a tag name. Currently used only in Compute Optimizer dashboard."
  type        = string
  default     = null
}

variable "quick_sight_data_source_role_name" {
  description = "IAM Role Name to be used on QuickSight Datasource Creation (if not provided, the default QuickSight Role will be used)."
  type        = string
  default     = "CidQuickSightDataSourceRole"
}

variable "lake_formation_enabled" {
  description = "I have LakeFormation permission model in place for this account & my cfn deployment credentials have administrative rights on LakeFormation"
  type        = string
  default     = "no"
}

variable "quicksight_user" {
  description = "An xisting QuickSight user"
  type        = string
  default     = null
}

variable "time_sleep_create_duration" {
  description = "Time to sleep before creating QuickSight dashboard and user"
  type        = string
  default     = "10s"
}

variable "lambda_powertools_version" {
  description = "Version of Lambda Powertools"
  type        = string
  default     = "PythonV2:68"

  validation {
    condition     = can(regex("^PythonV\\d+(-Arm64)?:\\d+$", var.lambda_powertools_version))
    error_message = "The lambda_powertools_version must be in the format 'PythonV<number>[-Arm64]:<number>'."
  }
}

variable "disable_quicksight_termination_protection_function_name" {
  description = "Name of the Lambda function to disable QuickSight account termination protection"
  type        = string
  default     = "CidDisableQuickSightAccountTerminationProtection"
}

variable "add_quicksight_data_set_permissions_function_name" {
  description = "Name of the Lambda function to add QuickSight data set permissions to new users"
  type        = string
  default     = "CidAddQuickSightDataSetPermissionsToUsers"
}

variable "enable_add_quicksight_data_set_permissions_lambda" {
  description = "Enable the Lambda function to add QuickSight data set permissions to new users"
  type        = bool
  default     = false
}

variable "enable_quicksight_termination_protection_lambda" {
  description = "Enable the Lambda function to disable QuickSight account termination protection"
  type        = bool
  default     = false
}

variable "add_quicksight_dataset_permissions_rule_name" {
  description = "The name of the CloudWatch event rule"
  type        = string
  default     = "CidAddQuickSightDataSetPermissionsToUsersRule"
}

variable "add_quicksight_dataset_permissions_role_name" {
  description = "The name of the IAM role"
  type        = string
  default     = "CidAddQuickSightDataSetPermissionsToUsersRole"
}

variable "quicksight_lambda_role_policy_name" {
  description = "The name of the IAM policy"
  type        = string
  default     = "CidQuickSightDataSetPermissions"
}

variable "quicksight_lambda_role_policy_sid" {
  description = "The SID of the IAM policy"
  type        = string
  default     = "CidQuickSightDataSetPermissions"
}

variable "quicksight_authentication_method" {
  description = "Method to authenticate your Amazon QuickSight account"
  type        = string
  default     = "IAM_AND_QUICKSIGHT"

  validation {
    condition     = can(regex("^(IAM_AND_QUICKSIGHT|IAM_ONLY|IAM_IDENTITY_CENTER|ACTIVE_DIRECTORY)$", var.quicksight_authentication_method))
    error_message = "The authentication_method must be one of 'IAM_AND_QUICKSIGHT', 'IAM_ONLY', 'IAM_IDENTITY_CENTER', or 'ACTIVE_DIRECTORY'."
  }
}

variable "quicksight_active_directory_name" {
  description = "The name of the Active Directory"
  type        = string
  default     = null
}

variable "quicksight_active_directory_admin_group" {
  description = "The name of the Active Directory admin group"
  type        = list(string)
  default     = null
}

variable "quicksight_active_directory_reader_group" {
  description = "The name of the Active Directory reader group"
  type        = list(string)
  default     = null
}

variable "quicksight_active_directory_author_group" {
  description = "The name of the Active Directory author group"
  type        = list(string)
  default     = null
}

variable "quicksight_active_directory_id" {
  description = "The ID of the Active Directory"
  type        = string
  default     = null
}

variable "quicksight_active_directory_realm" {
  description = "The realm of the Active Directory"
  type        = string
  default     = null
}

variable "quicksight_account_edition" {
  description = "The edition of the QuickSight account"
  type        = string
  default     = "ENTERPRISE"

  validation {
    condition     = can(regex("^(ENTERPRISE|STANDARD|ENTERPRISE_AND_Q)$", var.quicksight_account_edition))
    error_message = "The value must be one of 'ENTERPRISE', 'STANDARD', or 'ENTERPRISE_AND_Q'."
  }
}

variable "quicksight_enterprise_and_q_email" {
  description = "The email address of the QuickSight account. Required when the edition is 'ENTERPRISE_AND_Q'"
  type        = string
  default     = null

  validation {
    condition     = var.quicksight_enterprise_and_q_email == null || can(regex("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$", var.quicksight_enterprise_and_q_email))
    error_message = "The email address must be a valid email address."
  }
}

variable "quicksight_account_first_name" {
  description = "The first name of the QuickSight account. Required when the edition is 'ENTERPRISE_AND_Q'"
  type        = string
  default     = null
}

variable "quicksight_account_last_name" {
  description = "The last name of the QuickSight account. Required when the edition is 'ENTERPRISE_AND_Q'"
  type        = string
  default     = null
}

variable "quicksight_account_contact_number" {
  description = "The contact number of the QuickSight account. Required when the edition is 'ENTERPRISE_AND_Q'"
  type        = string
  default     = null

  validation {
    condition     = var.quicksight_account_contact_number == null || can(regex("^[0-9]{1,10}$", var.quicksight_account_contact_number))
    error_message = "The contact number must be a valid phone number."
  }
}

variable "quicksight_user_identity_type" {
  description = "The identity type of the QuickSight user"
  type        = string
  default     = "QUICKSIGHT"

  validation {
    condition     = can(regex("^(QUICKSIGHT|IAM)$", var.quicksight_user_identity_type))
    error_message = "The identity type must be one of 'QUICKSIGHT' or 'IAM'."
  }
}

variable "quicksight_user_role" {
  description = "The role of the QuickSight user"
  type        = string
  default     = "ADMIN"

  validation {
    condition     = can(regex("^(ADMIN|AUTHOR|READER)$", var.quicksight_user_role))
    error_message = "The role must be one of 'ADMIN', 'AUTHOR', or 'READER'."
  }
}

variable "quicksight_user_name" {
  description = "The name of the QuickSight user"
  type        = string
  default     = "QuickSightAdmin"
}

variable "quicksight_user_iam_arn" {
  description = "The ARN of the IAM user. Required if identity type is IAM."
  type        = string
  default     = null
}

variable "quicksight_user_email" {
  description = "The email of the QuickSight user"
  type        = string

  validation {
    condition     = var.quicksight_user_email == null || can(regex("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$", var.quicksight_user_email))
    error_message = "The email address must be a valid email address."
  }
}

variable "quicksight_user_namespace" {
  description = "The namespace of the QuickSight user"
  type        = string
  default     = "default"
}