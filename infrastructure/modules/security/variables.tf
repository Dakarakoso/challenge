variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "alb_sg_id" {
  description = "ALB security group ID"
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