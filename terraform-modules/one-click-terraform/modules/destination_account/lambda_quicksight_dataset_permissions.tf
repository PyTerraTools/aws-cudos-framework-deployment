resource "aws_lambda_function" "add_quicksight_dataset_permissions" {
  count = var.enable_add_quicksight_data_set_permissions_lambda == true ? 1 : 0

  function_name    = var.add_quicksight_data_set_permissions_function_name
  description      = "A Lambda function to add QuickSight data set permissions to new users."
  handler          = var.lambda_function_handler
  runtime          = var.lambda_function_runtime
  layers           = [local.aws_powertools_layer]
  timeout          = var.lambda_function_timeout
  role             = aws_iam_role.add_quicksight_dataset_permissions[0].arn
  source_code_hash = data.archive_file.add_quicksight_dataset_permissions[0].output_base64sha256
  filename         = data.archive_file.add_quicksight_dataset_permissions[0].output_path
  publish          = true
  environment {
    variables = {
      QUICKSIGHT_ACCOUNT_ID = data.aws_caller_identity.current.account_id
    }
  }
}

data "archive_file" "add_quicksight_dataset_permissions" {
  count = var.enable_add_quicksight_data_set_permissions_lambda == true ? 1 : 0

  type        = "zip"
  source_dir  = "${path.module}/lambda/quicksight_dataset_permissions"
  output_path = "${path.module}/lambda/quicksight_dataset_permissions.zip"
}

resource "aws_lambda_invocation" "add_quicksight_dataset_permissions" {
  count = var.enable_add_quicksight_data_set_permissions_lambda == true ? 1 : 0

  function_name = aws_lambda_function.add_quicksight_dataset_permissions[0].function_name
  input = jsonencode({
    "QUICKSIGHT_ACCOUNT_ID" = "${data.aws_caller_identity.current.account_id}"
  })

  triggers = {
    redeploy = aws_quicksight_account_subscription.cid_dashboards.account_subscription_status
  }

  lifecycle_scope = "CRUD"

  depends_on = [
    aws_quicksight_account_subscription.cid_dashboards,
    aws_lambda_function.add_quicksight_dataset_permissions
  ]
}

resource "aws_cloudwatch_event_rule" "add_quicksight_dataset_permissions" {
  count = var.enable_add_quicksight_data_set_permissions_lambda == true ? 1 : 0

  name        = var.add_quicksight_dataset_permissions_rule_name
  description = "Trigger the Lambda function to update QuickSight data set permissions."

  event_pattern = jsonencode({
    source = ["aws.quicksight"],
    detail = {
      eventName   = ["CreateUser", "CreateDataSet"],
      eventSource = ["quicksight.amazonaws.com"]
    }
  })

  depends_on = [
    aws_lambda_function.add_quicksight_dataset_permissions
  ]
}

resource "aws_cloudwatch_event_target" "add_quicksight_dataset_permissions" {
  count = var.enable_add_quicksight_data_set_permissions_lambda == true ? 1 : 0

  rule = aws_cloudwatch_event_rule.add_quicksight_dataset_permissions[0].name
  arn  = aws_lambda_function.add_quicksight_dataset_permissions[0].arn
}

resource "aws_iam_role" "add_quicksight_dataset_permissions" {
  count = var.enable_add_quicksight_data_set_permissions_lambda == true ? 1 : 0

  name               = var.add_quicksight_dataset_permissions_role_name
  assume_role_policy = data.aws_iam_policy_document.assume_lambda_service_role[0].json
}

resource "aws_iam_role_policy_attachment" "add_quicksight_dataset_permissions" {
  count = var.enable_add_quicksight_data_set_permissions_lambda == true ? 1 : 0

  role       = aws_iam_role.add_quicksight_dataset_permissions[0].name
  policy_arn = aws_iam_policy.quicksight_dataset_permissions[0].arn
}

resource "aws_iam_policy" "quicksight_dataset_permissions" {
  count = var.enable_add_quicksight_data_set_permissions_lambda == true ? 1 : 0

  name        = var.quicksight_lambda_role_policy_name
  description = "Allows the QuickSight Lambda function to update dataset permissions."
  policy      = data.aws_iam_policy_document.quicksight_dataset_permissions[0].json
}

data "aws_iam_policy_document" "quicksight_dataset_permissions" {
  count = var.enable_add_quicksight_data_set_permissions_lambda == true ? 1 : 0

  statement {
    sid    = var.quicksight_lambda_role_policy_sid
    effect = "Allow"
    actions = [
      "quicksight:UpdateAccountSettings",
      "quicksight:ListDataSets",
      "quicksight:ListUsers",
      "quicksight:UpdateDataSetPermissions",
      "quicksight:DescribeDataSet",
      "quicksight:DescribeDataSetPermissions",
      "quicksight:PassDataSet",
      "quicksight:DescribeIngestion",
      "quicksight:ListIngestions",
      "lambda:InvokeFunction",
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "assume_lambda_service_role" {
  count = var.enable_add_quicksight_data_set_permissions_lambda == true ? 1 : 0

  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}