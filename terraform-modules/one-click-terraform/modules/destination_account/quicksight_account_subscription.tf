resource "aws_quicksight_account_subscription" "cid_dashboards" {
  account_name          = "Cloud-Intelligence-Dashboards-${data.aws_caller_identity.current.account_id}"
  authentication_method = var.quicksight_authentication_method
  edition               = var.quicksight_account_edition
  notification_email    = var.quicksight_notifications_email
  active_directory_name = var.quicksight_authentication_method == "ACTIVE_DIRECTORY" ? var.quicksight_active_directory_name : null
  admin_group           = var.quicksight_authentication_method == "ACTIVE_DIRECTORY" ? var.quicksight_active_directory_admin_group : null
  reader_group          = var.quicksight_authentication_method == "ACTIVE_DIRECTORY" ? var.quicksight_active_directory_reader_group : null
  author_group          = var.quicksight_authentication_method == "ACTIVE_DIRECTORY" ? var.quicksight_active_directory_author_group : null
  directory_id          = var.quicksight_authentication_method == "ACTIVE_DIRECTORY" ? var.quicksight_active_directory_id : null
  realm                 = var.quicksight_authentication_method == "ACTIVE_DIRECTORY" ? var.quicksight_active_directory_realm : null
  email_address         = var.quicksight_account_edition == "ENTERPRISE_AND_Q" ? var.quicksight_enterprise_and_q_email : null
  first_name            = var.quicksight_account_edition == "ENTERPRISE_AND_Q" ? var.quicksight_account_first_name : null
  last_name             = var.quicksight_account_edition == "ENTERPRISE_AND_Q" ? var.quicksight_account_last_name : null
  contact_number        = var.quicksight_account_edition == "ENTERPRISE_AND_Q" ? var.quicksight_account_contact_number : null
}

resource "time_sleep" "wait_60" {
  depends_on      = [aws_quicksight_account_subscription.cid_dashboards]
  create_duration = var.quicksight_account_creation_wait_duration
}

resource "aws_quicksight_user" "cid_dashboards" {
  count = var.quicksight_user == null ? 1 : 0

  identity_type = var.quicksight_user_identity_type
  email         = var.quicksight_user_email
  user_role     = var.quicksight_user_role
  user_name     = var.quicksight_user_name
  iam_arn       = var.quicksight_user_identity_type == "IAM" ? var.quicksight_user_iam_arn : null
  namespace     = var.quicksight_user_namespace

  depends_on = [time_sleep.wait_60]
}
