output "source_account_cur_report_arn" {
  description = "ARN of the Cost and Usage Report"
  value       = module.cur_source.cur_report_arn
}

output "source_account_cur_bucket_arn" {
  description = "ARN of the S3 Bucket where the Cost and Usage Report is delivered"
  value       = module.cur_source.cur_bucket_arn
}

output "source_account_cur_bucket_name" {
  description = "Name of the S3 Bucket where the Cost and Usage Report is delivered"
  value       = module.cur_source.cur_bucket_name
}

output "source_account_replication_role_arn" {
  description = "ARN of the IAM role created for S3 replication"
  value       = module.cur_source.replication_role_arn
}

output "source_account_replication_role_name" {
  description = "ARN of the IAM role created for S3 replication"
  value       = module.cur_source.replication_role_name
}

output "destination_account_cur_report_arn" {
  description = "ARN of the Cost and Usage Report"
  value       = module.cur_destination.cur_report_arn
}

output "destination_account_cur_bucket_arn" {
  description = "ARN of the S3 Bucket where the Cost and Usage Report is delivered"
  value       = module.cur_destination.cur_bucket_arn
}

output "destination_account_cur_bucket_name" {
  description = "Name of the S3 Bucket where the Cost and Usage Report is delivered"
  value       = module.cur_destination.cur_bucket_name
}