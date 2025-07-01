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
  
}