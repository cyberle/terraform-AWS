variable "aws_region" {
  description = "The AWS region to deploy the S3 bucket into"
  type        = string
  default     = "ap-southeast-1"
}

variable "environment" {
  description = "Environment name (e.g., Dev, Prod, Lab)"
  type        = string
  default     = "Lab"
}

variable "bucket_name_prefix" {
  description = "Prefix for the S3 bucket name"
  type        = string
  default     = "app-data"
}
