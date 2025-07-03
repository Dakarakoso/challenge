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

output "alb_5xx_alarm_name" {
  description = "Name of the ALB 5XX CloudWatch alarm"
  value       = aws_cloudwatch_metric_alarm.alb_5xx.alarm_name
}

output "ecs_cpu_alarm_name" {
  description = "Name of the ECS high-CPU alarm"
  value       = aws_cloudwatch_metric_alarm.ecs_cpu.alarm_name
}

output "ecs_memory_alarm_name" {
  description = "Name of the ECS high-memory alarm"
  value       = aws_cloudwatch_metric_alarm.ecs_memory.alarm_name
}

output "rds_cpu_alarm_name" {
  description = "Name of the RDS high-CPU alarm"
  value       = aws_cloudwatch_metric_alarm.rds_cpu.alarm_name
}