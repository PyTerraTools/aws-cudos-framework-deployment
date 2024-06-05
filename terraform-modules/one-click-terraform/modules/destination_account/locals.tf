locals {
  aws_powertools_layer = "arn:aws:lambda:${data.aws_region.current.name}:017000801446:layer:AWSLambdaPowertools${var.lambda_powertools_version}"
}