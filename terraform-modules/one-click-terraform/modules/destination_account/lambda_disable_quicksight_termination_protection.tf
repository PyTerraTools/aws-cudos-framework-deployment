resource "aws_lambda_function" "disable_quicksight_account_termination_protection" {
  count = var.enable_quicksight_termination_protection_lambda == true ? 1 : 0

  function_name    = var.disable_quicksight_termination_protection_function_name
  description      = "A Lambda function to disable QuickSight account termination protection."
  handler          = var.lambda_function_handler
  runtime          = var.lambda_function_runtime
  layers           = [local.aws_powertools_layer]
  timeout          = var.lambda_function_timeout
  role             = aws_iam_role.add_quicksight_dataset_permissions[0].arn
  source_code_hash = data.archive_file.disable_quicksight_account_termination_protection[0].output_base64sha256
  filename         = data.archive_file.disable_quicksight_account_termination_protection[0].output_path
  publish          = true
  environment {
    variables = {
      QUICKSIGHT_ACCOUNT_ID = data.aws_caller_identity.current.account_id
    }
  }
}

data "archive_file" "disable_quicksight_account_termination_protection" {
  count = var.enable_quicksight_termination_protection_lambda == true ? 1 : 0

  type        = "zip"
  source_dir  = "${path.module}/lambda/termination_protection"
  output_path = "${path.module}/lambda/termination_protection.zip"
}

resource "aws_lambda_invocation" "disable_quicksight_account_termination_protection" {
  count = var.enable_quicksight_termination_protection_lambda == true ? 1 : 0

  function_name = aws_lambda_function.disable_quicksight_account_termination_protection[0].function_name
  input = jsonencode({
    "QUICKSIGHT_ACCOUNT_ID" = data.aws_caller_identity.current.account_id
  })

  triggers = {
    redeploy = aws_quicksight_account_subscription.cid_dashboards.account_subscription_status
  }

  lifecycle_scope = "CRUD"

  depends_on = [
    aws_quicksight_account_subscription.cid_dashboards,
    aws_lambda_function.disable_quicksight_account_termination_protection
  ]
}
