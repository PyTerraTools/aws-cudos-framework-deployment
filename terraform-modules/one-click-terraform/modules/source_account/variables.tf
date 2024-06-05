variable "source_account_ids" {
  description = "List of all source accounts that will replicate CUR Data. Ex:  [12345678912,98745612312,...] (fill only on Destination Account)"
  type        = list(string)
}

variable "create_cur" {
  description = "Whether to create a local CUR in the destination account or not. Set this to true if the destination account is NOT covered in the CUR of the source accounts.  Set to true when installing the dashboards in the Management/Payer account."
  type        = bool
  default     = false
}

variable "cur_name_suffix" {
  description = "Suffix to append to the CUR name. Default is 'cur'"
  type        = string
  default     = null
}

variable "resource_prefix" {
  description = "Prefix used for all named resources, including the S3 Bucket"
  type        = string
  default     = null
}
 