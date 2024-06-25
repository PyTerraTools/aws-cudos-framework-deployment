terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0"
      configuration_aliases = [
        aws.useast1,
        aws.dst,
        aws.dst_useast1,
        aws.src,
        aws.src_useast1
      ]
    }
  }
  required_version = ">= 1.2.0"
}
