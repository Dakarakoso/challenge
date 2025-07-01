output "db_endpoint" {
  value = aws_db_instance.main.endpoint
}

output "db_instance_id" {
  value = aws_db_instance.main.identifier
}

output "db_name" {
  value = aws_db_instance.main.db_name
}
