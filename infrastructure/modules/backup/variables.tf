variable "prefix" {
  description = "Resource name prefix"
  type        = string
}

variable "db_instance_arn" {
  description = "ARN of the RDS instance to backup"
  type        = string
}

variable "backup_schedule" {
  description = "Backup schedule in cron format"
  default     = "cron(0 5 * * ? *)" # Daily at 5 AM
}

variable "primary_retention_days" {
  description = "Retention days in primary region"
  default     = 35
}

variable "secondary_retention_days" {
  description = "Retention days in DR region"
  default     = 90
}