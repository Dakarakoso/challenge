terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0, < 7.0"
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
