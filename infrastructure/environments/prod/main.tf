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
  pgpassword_secret_arn = var.pgpassword_secret_arn
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

module "storage" {
  source = "../../modules/storage"

  bucket_name = "crm-attachments-${var.account_id}"
  kms_key_arn = module.security.kms_key_arn
}