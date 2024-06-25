resource "aws_s3_bucket" "template_bucket" {
  bucket_prefix = var.cid_template_bucket_prefix
  force_destroy = var.cid_template_bucket_force_destroy
}