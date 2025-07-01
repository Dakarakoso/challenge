output "ecs_sg_id" {
  value = aws_security_group.ecs.id
}

output "db_sg_id" {
  value = aws_security_group.db.id
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

output "waf_acl_arn" {
  value = aws_wafv2_web_acl.crm.arn
}