output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnets" {
  value = aws_subnet.public[*].id
}

output "private_subnets" {
  value = aws_subnet.private[*].id
}

output "alb_dns_name" {
  value = aws_alb.main.dns_name
}

output "alb_sg_id" {
  value = aws_security_group.alb.id
}

output "alb_target_group_arn" {
  value = aws_alb_target_group.main.arn
}

output "db_subnet_group" {
  value = aws_db_subnet_group.db.name
}

output "alb_listener_arn" {
  description = "ARN of the HTTPS listener"
  value       = aws_alb_listener.https.arn
}

output "blue_target_group_name" {
  description = "Name of the blue ECS target group"
  value       = aws_alb_target_group.main.name
}

output "green_target_group_name" {
  description = "Name of the green ECS target group"
  value       = aws_alb_target_group.green.name
}

output "blue_target_group_arn" {
  description = "ARN of the ‘blue’ target group"
  value       = aws_alb_target_group.main.arn
}

output "green_target_group_arn" {
  description = "ARN of the ‘green’ target group"
  value       = aws_alb_target_group.green.arn
}