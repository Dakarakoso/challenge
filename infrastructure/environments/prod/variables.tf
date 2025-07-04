# SSM Parameter names
variable "domain_name" {
  description = "SSM Parameter path for the public domain name"
  type        = string
}

variable "acm_certificate_arn" {
  description = "SSM Parameter path for the ACM certificate ARN"
  type        = string
}

variable "alarm_email" {
  description = "SSM Parameter path for the alert email address"
  type        = string
}

# Secrets Manager secret IDs (names or ARNs)
variable "db_password" {
  description = "Secrets Manager secret ID for DB master credentials"
  type        = string
}

variable "app_secret_value" {
  description = "Secrets Manager secret ID for the application secret"
  type        = string
}

variable "pgpassword_value" {
  description = "Secrets Manager secret ID for the Postgres superuser password"
  type        = string
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

variable "pgpassword_secret_arn" {
  description = "SecretsManager ARN for the Postgres superuser password"
  type        = string
}
variable "app_secret_arn" {
  description = "SecretsManager ARN for the application secret"
  type        = string
}

# Non-sensitive defaults:
variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}
variable "public_subnets" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets" {
  type    = list(string)
  default = ["10.0.3.0/24", "10.0.4.0/24"]
}
variable "azs" {
  type    = list(string)
  default = ["ap-northeast-1a", "ap-northeast-1b"]
}
variable "region" {
  type    = string
  default = "ap-northeast-1"
}
variable "dr_region" {
  type    = string
  default = "ap-southeast-1"
}
variable "db_instance_class" {
  type    = string
  default = "db.t3.medium"
}
variable "pipeline_name" {
  type    = string
  default = "crm-prod-deployment"
}
variable "prefix" {
  type    = string
  default = "crm-prod"
}
variable "account_id" {
  type    = string
  default = "123456789012"
}
variable "db_sg_ids" {
  type    = list(string)
  default = ["sg-0123456789abcdef0"]
}
variable "db_name" {
  type    = string
  default = "twenty"
}
variable "db_username" {
  type    = string
  default = "twenty_admin"
}

variable "monthly_budget_limit" {
  description = "Monthly budget limit in JPY"
  type        = number
  default     = 1000000
}

variable "budget_threshold_percent" {
  description = "Percent of budget at which to alert"
  type        = number
  default     = 80
}

variable "anomaly_threshold_amount" {
  description = "Absolute yen threshold for cost anomaly alerts"
  type        = number
  default     = 50000
}

variable "cur_s3_bucket" {
  description = "Name of the S3 bucket to receive CUR files"
  type        = string
  default     = "my-crm-cur-bucket"
}

variable "lambda_code_bucket" {
  type        = string
  description = "Bucket containing the Lambda ZIP"
  default     = "my-deployed-lambda-bucket"
}
variable "lambda_code_key" {
  type        = string
  description = "Key of the Lambda ZIP in S3"
  default     = "dr/promote-replica.zip"
}
