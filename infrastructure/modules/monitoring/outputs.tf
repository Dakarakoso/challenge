output "alarm_topic_arn" {
  value = aws_sns_topic.alarms.arn
}

output "vpc_flow_log_group" {
  value = aws_cloudwatch_log_group.flow_logs.name
}

output "flow_logs_log_group_arn" {
  description = "The ARN of the log group used for VPC flow logs"
  value       = aws_cloudwatch_log_group.flow_logs.arn
}
