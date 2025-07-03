output "db_endpoint" {
  value = aws_db_instance.main.endpoint
}

output "db_instance_id" {
  value = aws_db_instance.main.identifier
}

output "db_name" {
  value = aws_db_instance.main.db_name
}
output "db_arn" {
  description = "RDS instance ARN"
  value       = aws_db_instance.main.arn
}
output "replica_id" {
  value = aws_db_instance.replica.id
}

output "replica_arn" {
  value = aws_db_instance.replica.arn
}

output "main_id" {
  value       = aws_db_instance.main.id
  description = "The ID of the primary RDS instance"
}