terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0"
      configuration_aliases = [
        aws.useast1,
        aws.src,
        aws.dst,
        aws.dst_useast1,
        aws.src_useast1
      ]
    }
    time = {
      source  = "hashicorp/time"
      version = " ~> 0.10"
    }
    archive = {
      source  = "hashicorp/archive"
      version = "~> 2.4"
    }
  }
  required_version = ">= 1.2"
}