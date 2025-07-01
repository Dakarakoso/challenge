variable "vpc_id" {
  description = "VPC ID"
  type = string
}

variable "alb_sg_id" {
  description = "ALB security group ID"
  type = string
}

variable "s3_bucket_name" {
  description = "S3 bucket name for attachments"
  type = string
}

variable "account_id" {
  description = "AWS account ID"
  type = string
}

variable "pgpassword_value" {
  description = "Database password value"
  type = string
  sensitive = true
}

variable "app_secret_value" {
  description = "Application secret value"
  type = string
  sensitive = true
}

variable "pgpassword_secret_arn" {
  description = "Database password secret ARN"
  type = string
}

variable "app_secret_arn" {
  description = "App secret ARN"
  type = string
}