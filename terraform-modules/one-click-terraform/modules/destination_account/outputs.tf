output "quicksight_account_status" {
  description = "The status of Amazon Quicksight account's subscription"
  value       = aws_quicksight_account_subscription.cid_dashboards.account_subscription_status
}

output "destination_account_cur_report_arn" {
  description = "ARN of the Cost and Usage Report"
  value       = length(module.cur_destination) > 0 ? module.cur_destination[0].cur_report_arn : null
}

output "destination_account_cur_bucket_arn" {
  description = "ARN of the S3 Bucket where the Cost and Usage Report is delivered"
  value       = length(module.cur_destination) > 0 ? module.cur_destination[0].cur_bucket_arn : null
}

output "destination_account_cur_bucket_name" {
  description = "Name of the S3 Bucket where the Cost and Usage Report is delivered"
  value       = length(module.cur_destination) > 0 ? module.cur_destination[0].cur_bucket_name : null
}

output "cid_dashboards_stack_outputs" {
  description = "CloudFormation stack outputs (map of strings)"
  value       = module.cid_dashboards.stack_outputs
}

output "disable_quicksight_account_termination_protection_result" {
  description = "Result of the Lambda function to disable QuickSight account termination protection"
  value       = length(aws_lambda_invocation.disable_quicksight_account_termination_protection) > 0 ? jsondecode(aws_lambda_invocation.disable_quicksight_account_termination_protection[0].result) : null
}
