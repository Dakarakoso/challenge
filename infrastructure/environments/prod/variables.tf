variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
}

variable "public_subnets" {
  description = "Public subnets"
  type        = list(string)
}

variable "private_subnets" {
  description = "Private subnets"
  type        = list(string)
}

variable "azs" {
  description = "Availability zones"
  type        = list(string)
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
}