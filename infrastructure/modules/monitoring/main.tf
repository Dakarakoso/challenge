resource "aws_cloudwatch_metric_alarm" "ecs_cpu" {
  alarm_name = "ecs-high-cpu"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods = 2
  metric_name = "CPUUtilization"
  namespace = "AWS/ECS"
  period = 300
  statistic = "Average"
  threshold = 75
  alarm_actions = [aws_sns_topic.alarms.arn]

  dimensions = {
    ClusterName = var.ecs_cluster_name
    ServiceName = var.ecs_service_name
  }
}

resource "aws_cloudwatch_metric_alarm" "ecs_memory" {
  alarm_name = "ecs-high-memory"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name = "MemoryUtilization"
  namespace = "AWS/ECS"
  period = 300
  statistic = "Average"
  threshold = 80
  alarm_actions = [aws_sns_topic.alarms.arn]

  dimensions = {
    ClusterName = var.ecs_cluster_name
    ServiceName = var.ecs_service_name
  }
}

resource "aws_cloudwatch_metric_alarm" "rds_cpu" {
  alarm_name = "rds-high-cpu"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name = "CPUUtilization"
  namespace = "AWS/RDS"
  period = 300
  statistic = "Average"
  threshold = 80
  alarm_actions = [aws_sns_topic.alarms.arn]

  dimensions = {
    DBInstanceIdentifier = var.db_instance_id
  }
}

resource "aws_cloudwatch_metric_alarm" "alb_5xx" {
  alarm_name = "alb-high-5xx"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name  = "HTTPCode_Target_5XX_Count"
  namespace = "AWS/ApplicationELB"
  period = 60
  statistic = "Sum"
  threshold = 10
  alarm_actions = [aws_sns_topic.alarms.arn]

  dimensions = {
    LoadBalancer = var.alb_arn_suffix
  }
}

resource "aws_sns_topic" "alarms" {
  name = "crm-alarms-topic"
}

resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.alarms.arn
  protocol = "email"
  endpoint = var.alarm_email
}

resource "aws_cloudwatch_log_group" "flow_logs" {
  name              = "/aws/vpc/flow-logs"
  retention_in_days = 14

  tags = {
    Name = "crm-flow-logs"
  }
}