variable "aws_region" {
  description = "AWS region to deploy resources in"
  type        = string
  default     = "ap-south-1"
}

variable "bucket_name" {
  description = "Unique S3 bucket name"
  type        = string
}