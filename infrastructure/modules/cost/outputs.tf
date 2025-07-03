output "cur_bucket" {
  description = "Name of the CUR S3 bucket"
  value       = aws_s3_bucket.cur.bucket
}

output "budget_name" {
  description = "Name of the monthly budget"
  value       = aws_budgets_budget.monthly.name
}

output "anomaly_rule_arn" {
  description = "ARN of the EventBridge rule for cost anomalies"
  value       = aws_cloudwatch_event_rule.cost_anomaly.arn
}