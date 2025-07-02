output "ecs_sg_id" {
  value = aws_security_group.ecs.id
}

output "db_sg_id" {
  value = aws_security_group.db.id
}

output "kms_key_arn" {
  value = aws_kms_key.main.arn
}

output "ecs_exec_role_arn" {
  value = aws_iam_role.ecs_exec.arn
}

output "ecs_task_role_arn" {
  value = aws_iam_role.ecs_task.arn
}

output "pgpassword_secret_arn" {
  value = aws_secretsmanager_secret.pgpassword.arn
}

output "app_secret_arn" {
  value = aws_secretsmanager_secret.app_secret.arn
}

output "waf_acl_arn" {
  value = aws_wafv2_web_acl.crm.arn
}
output "vpc_flow_logs_role_arn" {
  description = "IAM role ARN for VPC Flow Logs"
  value       = aws_iam_role.vpc_flow_logs.arn
}