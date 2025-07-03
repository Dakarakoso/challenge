variable "repository_name" {
  description = "CodeCommit repository name"
  type        = string
}

variable "build_project_name" {
  description = "CodeBuild project name"
  type        = string
}

variable "pipeline_name" {
  description = "CodePipeline name"
  type        = string
}

variable "ecs_cluster_name" {
  description = "ECS cluster name"
  type        = string
}

variable "ecs_service_name" {
  description = "ECS service name"
  type        = string
}

variable "account_id" {
  description = "AWS account ID"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "alb_listener_arn" {
  type = string
}

variable "blue_target_group_name" {
  type = string
}

variable "green_target_group_name" {
  type = string
}