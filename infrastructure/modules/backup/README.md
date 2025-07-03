## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_aws.dr_region"></a> [aws.dr\_region](#provider\_aws.dr\_region) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_backup_plan.cross_region](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/backup_plan) | resource |
| [aws_backup_selection.rds](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/backup_selection) | resource |
| [aws_backup_vault.primary](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/backup_vault) | resource |
| [aws_backup_vault.secondary](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/backup_vault) | resource |
| [aws_iam_role.backup_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.backup_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_backup_schedule"></a> [backup\_schedule](#input\_backup\_schedule) | Backup schedule in cron format | `string` | `"cron(0 5 * * ? *)"` | no |
| <a name="input_db_instance_arn"></a> [db\_instance\_arn](#input\_db\_instance\_arn) | ARN of the RDS instance to backup | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Resource name prefix | `string` | n/a | yes |
| <a name="input_primary_retention_days"></a> [primary\_retention\_days](#input\_primary\_retention\_days) | Retention days in primary region | `number` | `35` | no |
| <a name="input_secondary_retention_days"></a> [secondary\_retention\_days](#input\_secondary\_retention\_days) | Retention days in DR region | `number` | `90` | no |

## Outputs

No outputs.
