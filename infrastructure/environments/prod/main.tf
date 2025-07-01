terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.0.0"
    }
  }

  # backend "s3" {
  #   profile    = "twentyhq"
  #   region     = "ap-northeast-1"
  #   key        = "terraform.tfstate"
  #   encrypt    = true
  #   kms_key_id = "alias/production-terraform-state"
  # }ter
}

provider "aws" {
  region  = var.region
  profile = "twentyhq"
}


module "networking" {
    source = "../../modules/networking"

    vpc_cidr = var.vpc_cidr
    public_subnets = var.public_subnets
    private_subnets = var.private_subnets
    azs = var.azs
    acm_certificate_arn = var.acm_certificate_arn
}

module "security" {
  source = "../../modules/security"
  
  vpc_id = module.networking.vpc_id
  alb_sg_id = module.networking.alb_sg_id
  s3_bucket_name  = module.storage.s3_bucket_name
  account_id = var.account_id
  pgpassword_value = var.pgpassword_value
  app_secret_value = var.app_secret_value
  pgpassword_secret_arn = var.pgpassword_secret_arn
  app_secret_arn = var.app_secret_arn
}

module "database" {
  source = "../../modules/database"
  
  db_subnet_group = module.networking.db_subnet_group
  db_sg_id = module.security.db_sg_id
  db_name = var.db_name
  db_username = var.db_username
  db_password  = var.db_password
  kms_key_arn = module.security.kms_key_arn
  db_subnets = module.networking.private_subnets
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
  source = "../../modules/ci_cd"
  repository_name = "crm-app"
  build_project_name = "crm-build"
  pipeline_name = "crm-deployment"
  ecs_cluster_name = module.compute.cluster_name
  ecs_service_name = module.compute.server_service_name
  account_id = var.account_id
  region = var.region
}