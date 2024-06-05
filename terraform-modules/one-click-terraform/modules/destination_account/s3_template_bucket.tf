resource "aws_s3_bucket" "template_bucket" {
  bucket_prefix = "cid-cf-template-"
  force_destroy = true
}