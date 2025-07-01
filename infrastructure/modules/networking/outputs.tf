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