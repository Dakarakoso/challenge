## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0, < 7.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_backup"></a> [backup](#module\_backup) | ../../modules/backup | n/a |
| <a name="module_ci_cd"></a> [ci\_cd](#module\_ci\_cd) | ../../modules/ci_cd | n/a |
| <a name="module_compute"></a> [compute](#module\_compute) | ../../modules/compute | n/a |
| <a name="module_cost"></a> [cost](#module\_cost) | ../../modules/cost | n/a |
| <a name="module_database"></a> [database](#module\_database) | ../../modules/database | n/a |
| <a name="module_edge"></a> [edge](#module\_edge) | ../../modules/edge | n/a |
| <a name="module_failover"></a> [failover](#module\_failover) | ../../modules/failover | n/a |
| <a name="module_monitoring"></a> [monitoring](#module\_monitoring) | ../../modules/monitoring | n/a |
| <a name="module_networking"></a> [networking](#module\_networking) | ../../modules/networking | n/a |
| <a name="module_security"></a> [security](#module\_security) | ../../modules/security | n/a |
| <a name="module_storage"></a> [storage](#module\_storage) | ../../modules/storage | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_id"></a> [account\_id](#input\_account\_id) | n/a | `string` | `"123456789012"` | no |
| <a name="input_acm_certificate_arn"></a> [acm\_certificate\_arn](#input\_acm\_certificate\_arn) | SSM Parameter path for the ACM certificate ARN | `string` | n/a | yes |
| <a name="input_alarm_email"></a> [alarm\_email](#input\_alarm\_email) | SSM Parameter path for the alert email address | `string` | n/a | yes |
| <a name="input_anomaly_threshold_amount"></a> [anomaly\_threshold\_amount](#input\_anomaly\_threshold\_amount) | Absolute yen threshold for cost anomaly alerts | `number` | `50000` | no |
| <a name="input_app_initial_secret"></a> [app\_initial\_secret](#input\_app\_initial\_secret) | Initial application secret (bootstrap value) | `string` | n/a | yes |
| <a name="input_app_secret_arn"></a> [app\_secret\_arn](#input\_app\_secret\_arn) | SecretsManager ARN for the application secret | `string` | n/a | yes |
| <a name="input_app_secret_value"></a> [app\_secret\_value](#input\_app\_secret\_value) | Secrets Manager secret ID for the application secret | `string` | n/a | yes |
| <a name="input_azs"></a> [azs](#input\_azs) | n/a | `list(string)` | <pre>[<br/>  "ap-northeast-1a",<br/>  "ap-northeast-1b"<br/>]</pre> | no |
| <a name="input_budget_threshold_percent"></a> [budget\_threshold\_percent](#input\_budget\_threshold\_percent) | Percent of budget at which to alert | `number` | `80` | no |
| <a name="input_cur_s3_bucket"></a> [cur\_s3\_bucket](#input\_cur\_s3\_bucket) | Name of the S3 bucket to receive CUR files | `string` | `"my-crm-cur-bucket"` | no |
| <a name="input_db_initial_password"></a> [db\_initial\_password](#input\_db\_initial\_password) | Initial DB master password (used once to bootstrap the secret) | `string` | n/a | yes |
| <a name="input_db_instance_class"></a> [db\_instance\_class](#input\_db\_instance\_class) | n/a | `string` | `"db.t3.medium"` | no |
| <a name="input_db_name"></a> [db\_name](#input\_db\_name) | n/a | `string` | `"twenty"` | no |
| <a name="input_db_password"></a> [db\_password](#input\_db\_password) | Secrets Manager secret ID for DB master credentials | `string` | n/a | yes |
| <a name="input_db_sg_ids"></a> [db\_sg\_ids](#input\_db\_sg\_ids) | n/a | `list(string)` | <pre>[<br/>  "sg-0123456789abcdef0"<br/>]</pre> | no |
| <a name="input_db_username"></a> [db\_username](#input\_db\_username) | n/a | `string` | `"twenty_admin"` | no |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | SSM Parameter path for the public domain name | `string` | n/a | yes |
| <a name="input_dr_region"></a> [dr\_region](#input\_dr\_region) | n/a | `string` | `"ap-southeast-1"` | no |
| <a name="input_lambda_code_bucket"></a> [lambda\_code\_bucket](#input\_lambda\_code\_bucket) | Bucket containing the Lambda ZIP | `string` | `"my-deployed-lambda-bucket"` | no |
| <a name="input_lambda_code_key"></a> [lambda\_code\_key](#input\_lambda\_code\_key) | Key of the Lambda ZIP in S3 | `string` | `"dr/promote-replica.zip"` | no |
| <a name="input_monthly_budget_limit"></a> [monthly\_budget\_limit](#input\_monthly\_budget\_limit) | Monthly budget limit in JPY | `number` | `1000000` | no |
| <a name="input_pg_initial_password"></a> [pg\_initial\_password](#input\_pg\_initial\_password) | Initial Postgres superuser password (bootstrap value) | `string` | n/a | yes |
| <a name="input_pgpassword_secret_arn"></a> [pgpassword\_secret\_arn](#input\_pgpassword\_secret\_arn) | SecretsManager ARN for the Postgres superuser password | `string` | n/a | yes |
| <a name="input_pgpassword_value"></a> [pgpassword\_value](#input\_pgpassword\_value) | Secrets Manager secret ID for the Postgres superuser password | `string` | n/a | yes |
| <a name="input_pipeline_name"></a> [pipeline\_name](#input\_pipeline\_name) | n/a | `string` | `"crm-prod-deployment"` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | `"crm-prod"` | no |
| <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | n/a | `list(string)` | <pre>[<br/>  "10.0.3.0/24",<br/>  "10.0.4.0/24"<br/>]</pre> | no |
| <a name="input_public_subnets"></a> [public\_subnets](#input\_public\_subnets) | n/a | `list(string)` | <pre>[<br/>  "10.0.1.0/24",<br/>  "10.0.2.0/24"<br/>]</pre> | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"ap-northeast-1"` | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | Non-sensitive defaults: | `string` | `"10.0.0.0/16"` | no |

## Outputs

No outputs.
