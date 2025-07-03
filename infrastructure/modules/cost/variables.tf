variable "prefix" {
  description = "Name prefix"
  type        = string
}

variable "region" {
  description = "AWS region for CUR bucket & budgets"
  type        = string
}

variable "cur_s3_bucket" {
  description = "S3 bucket to receive CUR files (must exist)"
  type        = string
}

variable "alert_email" {
  description = "Email for budget and anomaly notifications"
  type        = string
}

variable "monthly_budget_limit" {
  description = "Budget limit in JPY"
  type        = number
  default     = 100000
}

variable "budget_threshold_amount" {
  description = "Alert threshold as percentage of JPY budget"
  type        = number
  default     = 80
}

variable "anomaly_threshold_amount" {
  description = "Absolute JPY threshold for anomaly alerts"
  type        = number
  default     = 20000
}

