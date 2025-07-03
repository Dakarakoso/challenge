variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "Public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets" {
  description = "Private subnets"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "azs" {
  description = "Availability zones"
  type        = list(string)
  default     = ["ap-northeast-1a", "ap-northeast-1b"]
}

variable "domain_name" {
  description = "Domain name"
  type        = string
}

variable "acm_certificate_arn" {
  description = "ACM certificate ARN"
  type        = string
}

variable "account_id" {
  description = "AWS account ID"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-northeast-1"
}

variable "db_name" {
  description = "Database name"
  type        = string
}

variable "db_username" {
  description = "Database username"
  type        = string
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}

variable "pgpassword_value" {
  description = "Database superuser password"
  type        = string
  sensitive   = true
}

variable "app_secret_value" {
  description = "Database superuser password"
  type        = string
  sensitive   = true
}

variable "pgpassword_secret_arn" {
  description = "value"
  default     = "dummy-arn"
}
variable "app_secret_arn" {
  type        = string
  description = "value"
  default     = "dummy-arn"
}

variable "alarm_email" {
  description = "Email for alarm notifications"
  type        = string
}

variable "access_key" {
  type    = string
  default = "mock_access_key"
}

variable "secret_key" {
  type    = string
  default = "mock_secret_key"
}

variable "dr_region" {
  description = "Disaster recovery region"
  type        = string
  default     = "ap-southeast-1"
}

variable "pipeline_name" {
  type        = string
  description = "Name prefix for the CodePipeline and related resources"
  default     = "crm-prod-deployment"
}

variable "prefix" {
  type        = string
  description = "Resource Prefix"
  default     = "crm-prod"
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

variable "db_instance_class" {
  description = "RDS instance class (e.g. db.t3.medium)"
  type        = string
  default     = "db.t3.medium"
}

variable "db_sg_ids" {
  description = "List of security group IDs to attach to the database"
  type        = list(string)
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