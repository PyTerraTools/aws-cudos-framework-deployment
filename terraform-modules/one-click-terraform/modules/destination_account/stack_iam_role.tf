data "aws_iam_policy_document" "s3_get_object" {
  statement {
    actions = [
      "iam:DeleteRole*",
      "iam:DetachRole*",
      "lambda:*",
      "glue:*",
      "athena:*",
      "s3:*",
      "quicksight:*",
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "s3_get_object" {
  name        = "s3_get_object"
  description = "Allows s3:GetObject access to specific S3 object"
  policy      = data.aws_iam_policy_document.s3_get_object.json
}

resource "aws_iam_role_policy_attachment" "s3_get_object_attach" {
  role       = aws_iam_role.cid_stack_role.name
  policy_arn = aws_iam_policy.s3_get_object.arn
}


data "aws_iam_policy_document" "cid_stack_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["cloudformation.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "cid_stack_role" {
  name               = "CidCloudFormationStackRole"
  assume_role_policy = data.aws_iam_policy_document.cid_stack_assume_role_policy.json
}
