## Requirements

The following requirements are needed by this module:

- <a name="requirement_aws"></a> [aws](#requirement\_aws) (6.0.0)

## Providers

No providers.

## Modules

The following Modules are called:

### <a name="module_backup"></a> [backup](#module\_backup)

Source: ../../modules/backup

Version:

### <a name="module_ci_cd"></a> [ci\_cd](#module\_ci\_cd)

Source: ../../modules/ci_cd

Version:

### <a name="module_compute"></a> [compute](#module\_compute)

Source: ../../modules/compute

Version:

### <a name="module_database"></a> [database](#module\_database)

Source: ../../modules/database

Version:

### <a name="module_edge"></a> [edge](#module\_edge)

Source: ../../modules/edge

Version:

### <a name="module_monitoring"></a> [monitoring](#module\_monitoring)

Source: ../../modules/monitoring

Version:

### <a name="module_networking"></a> [networking](#module\_networking)

Source: ../../modules/networking

Version:

### <a name="module_security"></a> [security](#module\_security)

Source: ../../modules/security

Version:

### <a name="module_storage"></a> [storage](#module\_storage)

Source: ../../modules/storage

Version:

## Resources

No resources.

## Required Inputs

The following input variables are required:

### <a name="input_account_id"></a> [account\_id](#input\_account\_id)

Description: AWS account ID

Type: `string`

### <a name="input_acm_certificate_arn"></a> [acm\_certificate\_arn](#input\_acm\_certificate\_arn)

Description: ACM certificate ARN

Type: `string`

### <a name="input_alarm_email"></a> [alarm\_email](#input\_alarm\_email)

Description: Email for alarm notifications

Type: `string`

### <a name="input_app_secret_value"></a> [app\_secret\_value](#input\_app\_secret\_value)

Description: Database superuser password

Type: `string`

### <a name="input_azs"></a> [azs](#input\_azs)

Description: Availability zones

Type: `list(string)`

### <a name="input_db_name"></a> [db\_name](#input\_db\_name)

Description: Database name

Type: `string`

### <a name="input_db_password"></a> [db\_password](#input\_db\_password)

Description: Database password

Type: `string`

### <a name="input_db_username"></a> [db\_username](#input\_db\_username)

Description: Database username

Type: `string`

### <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name)

Description: Domain name

Type: `string`

### <a name="input_dr_region"></a> [dr\_region](#input\_dr\_region)

Description: Disaster recovery region

Type: `string`

### <a name="input_pgpassword_value"></a> [pgpassword\_value](#input\_pgpassword\_value)

Description: Database superuser password

Type: `string`

### <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets)

Description: Private subnets

Type: `list(string)`

### <a name="input_public_subnets"></a> [public\_subnets](#input\_public\_subnets)

Description: Public subnets

Type: `list(string)`

### <a name="input_region"></a> [region](#input\_region)

Description: AWS region

Type: `string`

### <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr)

Description: VPC CIDR block

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_access_key"></a> [access\_key](#input\_access\_key)

Description: n/a

Type: `string`

Default: `"mock_access_key"`

### <a name="input_app_secret_arn"></a> [app\_secret\_arn](#input\_app\_secret\_arn)

Description: value

Type: `string`

Default: `"dummy-arn"`

### <a name="input_pgpassword_secret_arn"></a> [pgpassword\_secret\_arn](#input\_pgpassword\_secret\_arn)

Description: value

Type: `string`

Default: `"dummy-arn"`

### <a name="input_secret_key"></a> [secret\_key](#input\_secret\_key)

Description: n/a

Type: `string`

Default: `"mock_secret_key"`

## Outputs

No outputs.
