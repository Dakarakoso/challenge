variable "cluster_name" {
  description = "ECS cluster name"
  type = string
}

variable "execution_role_arn" {
  description = "ECS execution role ARN"
  type = string
}

variable "task_role_arn" {
  description = "ECS task role ARN"
  type = string
}

variable "server_image" {
  description = "Server container image"
  type = string
}

variable "worker_image" {
  description = "Worker container image"
  type = string
}

variable "private_subnets" {
  description = "Private subnets for ECS"
  type = list(string)
}

variable "ecs_security_group_id" {
  description = "ECS security group ID"
  type = string
}

variable "alb_target_group_arn" {
  description = "ALB target group ARN"
  type = string
}

variable "region" {
  description = "AWS region"
  type = string
}

variable "server_url" {
  description = "Application server URL"
  type = string
}

variable "db_endpoint" {
  description = "Database endpoint"
  type = string
}

variable "db_name" {
  description = "Database name"
  type = string
}

variable "db_username" {
  description = "Database username"
  type = string
}

variable "s3_bucket_name" {
  description = "S3 bucket name"
  type = string
}

variable "app_secret_arn" {
  description = "App secret ARN"
  type = string
}

variable "pgpassword_secret_arn" {
  description = "Database password secret ARN"
  type = string
}

variable "kms_key_arn" {
  description = "KMS key ARN"
  type = string
}

variable "server_cpu" {
  description = "Server CPU units"
  type = number
  default = 512
}

variable "server_memory" {
  description = "Server memory (MB)"
  type = number
  default = 1024
}

variable "worker_cpu" {
  description = "Worker CPU units"
  type = number
  default = 256
}

variable "worker_memory" {
  description = "Worker memory (MB)"
  type = number
  default = 512
}

variable "server_container_port" {
  description = "Server container port"
  type = number
  default = 3000
}

variable "server_desired_count" {
  description = "Server desired count"
  type = number
  default = 2
}

variable "worker_desired_count" {
  description = "Worker desired count"
  type = number
  default = 1
}

variable "server_min_capacity" {
  description = "Server min capacity"
  type = number
  default = 2
}

variable "server_max_capacity" {
  description = "Server max capacity"
  type = number
  default = 10
}

variable "cloudwatch_log_group" {
  description = "CloudWatch log group name"
  type = string
}