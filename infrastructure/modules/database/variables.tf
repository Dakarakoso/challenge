variable "db_subnet_group" {
  description = "Database subnet group name"
  type        = string
}

variable "db_sg_id" {
  description = "Database security group ID"
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

variable "kms_key_arn" {
  description = "KMS key ARN for encryption"
  type        = string
}

variable "db_subnets" {
  description = "Database subnets"
  type        = list(string)
}

variable "prefix" {
  type        = string
  description = "Name prefix for all DB resources"
}

variable "db_instance_class" {
  type        = string
  description = "RDS instance class"
}

variable "db_sg_ids" {
  type        = list(string)
  description = "List of security group IDs for the DB"
}
