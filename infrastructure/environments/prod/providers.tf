# Primary region
provider "aws" {
  region = var.region
  # profile = "twentyhq"
  access_key                  = "mock_access_key"
  secret_key                  = "mock_secret_key"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
}

# Secondary region
provider "aws" {
  alias  = "dr_region"
  region = var.dr_region
}