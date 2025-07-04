variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "alb_sg_id" {
  description = "ALB security group ID"
  type        = string
}

variable "s3_bucket_name" {
  description = "S3 bucket name for attachments"
  type        = string
}

variable "account_id" {
  description = "AWS account ID"
  type        = string
}

variable "pgpassword_value" {
  description = "Database password value"
  type        = string
  sensitive   = true
}

variable "app_secret_value" {
  description = "Application secret value"
  type        = string
  sensitive   = true
}

variable "pgpassword_secret_arn" {
  description = "Database password secret ARN"
  type        = string
}

variable "app_secret_arn" {
  description = "App secret ARN"
  type        = string
}

variable "domain_name" {
  description = "SSM Parameter path for the public domain name"
  type        = string
}

variable "acm_certificate_arn" {
  description = "SSM Parameter path for the ACM certificate ARN"
  type        = string
}

variable "region" {
  type = string
}

variable "alarm_email" {
  description = "SSM Parameter path for the alert email address"
  type        = string
}

variable "db_password" {
  description = "Secrets Manager secret ID for DB master credentials"
  type        = string
}

variable "db_username" {
  type = string
}


# Initial secret values (sensitive)
variable "db_initial_password" {
  description = "Initial DB master password (used once to bootstrap the secret)"
  type        = string
  sensitive   = true
}

variable "app_initial_secret" {
  description = "Initial application secret (bootstrap value)"
  type        = string
  sensitive   = true
}

variable "pg_initial_password" {
  description = "Initial Postgres superuser password (bootstrap value)"
  type        = string
  sensitive   = true
}