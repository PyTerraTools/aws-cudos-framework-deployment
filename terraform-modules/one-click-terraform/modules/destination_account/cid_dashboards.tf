# https://github.com/aws-samples/aws-cudos-framework-deployment/tree/main/terraform-modules/cid-dashboards
module "cid_dashboards" {
  source = "github.com/aws-samples/aws-cudos-framework-deployment//terraform-modules/cid-dashboards?ref=0.3.4"

  stack_name        = var.stack_name
  template_bucket   = aws_s3_bucket.template_bucket.id
  stack_iam_role    = var.stack_iam_role
  stack_policy_body = var.stack_policy_body
  stack_parameters = {
    "CURBucketPath"                        = var.cur_bucket_path
    "DataBuketsKmsKeyArns"                 = var.data_buckets_kms_key_arns
    "DeployComputeOptimizerDashboard"      = var.deploy_compute_optimizer_dashboard
    "DeployCUDOSDashboard"                 = var.deploy_cudos_dashboard
    "DeployCUDOSv5"                        = var.deploy_cudos_v5_dashboard
    "DeployCostIntelligenceDashboard"      = var.deploy_cost_intelligence_dashboard
    "DeployKPIDashboard"                   = var.deploy_kpi_dashboard
    "DeployTAODashboard"                   = var.deploy_tao_dashboard
    "LakeFormationEnabled"                 = var.lake_formation_enabled
    "OptimizationDataCollectionBucketPath" = var.optimization_data_collection_bucket_path
    "PrimaryTagName"                       = var.primary_tag_name
    "PrerequisitesQuickSight"              = var.prerequisites_quick_sight
    "PrerequisitesQuickSightPermissions"   = var.prerequisites_quick_sight_permissions
    "QuickSightDataSourceRoleName"         = var.quick_sight_data_source_role_name
    "QuickSightDataSetRefreshSchedule"     = var.quick_sight_data_set_refresh_schedule
    "QuickSightUser"                       = var.quicksight_user == null ? aws_quicksight_user.cid_dashboards[0].user_name : var.quicksight_user
    "SecondaryTagName"                     = var.secondary_tag_name
  }

  depends_on = [
    time_sleep.wait,
    aws_quicksight_account_subscription.cid_dashboards,
    aws_quicksight_user.cid_dashboards
  ]
}

resource "time_sleep" "wait" {
  depends_on      = [aws_iam_role.cid_stack_role]
  create_duration = var.time_sleep_create_duration
}
