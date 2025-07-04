# Hardcoded values Terraform plan/apply works without real AWS credentials or live SSM/Secrets Manager entries.

# data "aws_ssm_parameter" "domain_name" {
#   name = var.domain_name
# }

# data "aws_ssm_parameter" "cert_arn" {
#   name = var.acm_certificate_arn
# }

# data "aws_ssm_parameter" "alert_email" {
#   name = var.alarm_email
# }

# data "aws_secretsmanager_secret_version" "db_creds" {
#   secret_id = var.db_password
# }
# locals {
#   db_creds = jsondecode(data.aws_secretsmanager_secret_version.db_creds.secret_string)
# }

# data "aws_secretsmanager_secret_version" "app_secret" {
#   secret_id = var.app_secret_value
# }

# data "aws_secretsmanager_secret_version" "pg_super" {
#   secret_id = var.pgpassword_value
# }

module "networking" {
  source = "../../modules/networking"

  vpc_cidr               = var.vpc_cidr
  public_subnets         = var.public_subnets
  private_subnets        = var.private_subnets
  azs                    = var.azs
  acm_certificate_arn    = var.acm_certificate_arn
  vpc_flow_logs_role_arn = module.security.vpc_flow_logs_role_arn
  log_group_arn          = module.monitoring.flow_logs_log_group_arn

}

module "security" {
  source = "../../modules/security"

  vpc_id                = module.networking.vpc_id
  alb_sg_id             = module.networking.alb_sg_id
  s3_bucket_name        = module.storage.s3_bucket_name
  account_id            = var.account_id
  pgpassword_value      = var.pgpassword_value
  app_secret_value      = var.app_secret_value
  pgpassword_secret_arn = var.pgpassword_secret_arn
  app_secret_arn        = var.app_secret_arn
  app_initial_secret    = var.app_initial_secret
  db_initial_password   = var.db_initial_password
  pg_initial_password   = var.pg_initial_password
  domain_name           = var.domain_name
  db_username           = var.db_username
  db_password           = var.db_password
  region                = var.region
  alarm_email           = var.alarm_email
  acm_certificate_arn   = var.acm_certificate_arn
}

module "database" {
  source = "../../modules/database"
  providers = {
    aws           = aws
    aws.dr_region = aws.dr_region
  }
  prefix            = var.prefix
  db_instance_class = var.db_instance_class
  db_sg_ids         = var.db_sg_ids
  db_subnet_group   = module.networking.db_subnet_group
  db_sg_id          = module.security.db_sg_id
  db_name           = var.db_name
  db_username       = var.db_username
  db_password       = var.db_password
  kms_key_arn       = module.security.kms_key_arn
  db_subnets        = module.networking.private_subnets
}

module "compute" {
  source = "../../modules/compute"

  cluster_name          = "crm-cluster"
  execution_role_arn    = module.security.ecs_exec_role_arn
  task_role_arn         = module.security.ecs_task_role_arn
  server_image          = "${var.account_id}.dkr.ecr.${var.region}.amazonaws.com/twenty-server:latest"
  worker_image          = "${var.account_id}.dkr.ecr.${var.region}.amazonaws.com/twenty-worker:latest"
  private_subnets       = module.networking.private_subnets
  ecs_security_group_id = module.security.ecs_sg_id
  alb_target_group_arn  = module.networking.alb_target_group_arn
  cloudwatch_log_group  = "/ecs/crm-app"
  region                = var.region
  server_url            = "https://${var.domain_name}"
  db_endpoint           = module.database.db_endpoint
  db_name               = module.database.db_name
  db_username           = var.db_username
  s3_bucket_name        = module.storage.s3_bucket_name
  app_secret_arn        = module.security.app_secret_arn
  pgpassword_secret_arn = module.security.pgpassword_secret_arn
  kms_key_arn           = module.security.kms_key_arn
}

module "storage" {
  source = "../../modules/storage"

  bucket_name = "crm-attachments-${var.account_id}"
  kms_key_arn = module.security.kms_key_arn
}

module "ci_cd" {
  source                  = "../../modules/ci_cd"
  repository_name         = "challenge"
  build_project_name      = "crm-build"
  pipeline_name           = var.pipeline_name
  ecs_cluster_name        = module.compute.cluster_name
  ecs_service_name        = module.compute.server_service_name
  account_id              = var.account_id
  region                  = var.region
  alb_listener_arn        = module.networking.alb_listener_arn
  blue_target_group_name  = module.networking.blue_target_group_name
  green_target_group_name = module.networking.green_target_group_name
  alb_alarm_name          = module.monitoring.alb_5xx_alarm_name
  ecs_cpu_alarm_name      = module.monitoring.ecs_cpu_alarm_name
  ecs_memory_alarm_name   = module.monitoring.ecs_memory_alarm_name
  rds_cpu_alarm_name      = module.monitoring.rds_cpu_alarm_name

}


module "edge" {
  source = "../../modules/edge"

  domain_name         = var.domain_name
  alb_dns_name        = module.networking.alb_dns_name
  acm_certificate_arn = var.acm_certificate_arn
  waf_acl_arn         = module.security.waf_acl_arn
}

module "monitoring" {
  source           = "../../modules/monitoring"
  ecs_cluster_name = module.compute.cluster_name
  ecs_service_name = module.compute.server_service_name
  db_instance_id   = module.database.db_instance_id
  alb_arn_suffix   = split("/", module.networking.alb_target_group_arn)[1]
  alarm_email      = var.alarm_email
  prefix           = "crm-prod"
  pipeline_name    = var.pipeline_name
}

module "backup" {
  source = "../../modules/backup"

  providers = {
    aws.dr_region = aws.dr_region
  }
  prefix          = var.prefix
  db_instance_arn = module.database.db_arn
  backup_schedule = "cron(0 3 * * ? *)" # 3 AM UTC

}

module "failover" {
  source = "../../modules/failover"

  prefix           = var.prefix
  primary_db_id    = module.database.main_id
  replica_id       = module.database.replica_id
  replica_arn      = module.database.replica_arn
  lambda_s3_bucket = var.lambda_code_bucket
  lambda_s3_key    = var.lambda_code_key
}

module "cost" {
  source = "../../modules/cost"

  prefix                   = var.prefix
  region                   = var.region
  cur_s3_bucket            = var.cur_s3_bucket
  alert_email              = var.alarm_email
  monthly_budget_limit     = var.monthly_budget_limit
  budget_threshold_amount  = var.budget_threshold_percent
  anomaly_threshold_amount = var.anomaly_threshold_amount

}