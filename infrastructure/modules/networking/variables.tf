variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnets" {
  description = "List of public subnet CIDRs"
  type        = list(string)
}

variable "private_subnets" {
  description = "List of private subnet CIDRs"
  type        = list(string)
}

variable "azs" {
  description = "Availability zones"
  type        = list(string)
}

variable "acm_certificate_arn" {
  description = "ACM certificate ARN for HTTPS"
  type        = string
}

variable "log_group_arn" {
  description = "CloudWatch Log Group ARN for VPC Flow Logs"
  type        = string
}

variable "vpc_flow_logs_role_arn" {
  type        = string
  description = "IAM role ARN to use for VPC Flow Logs"
}