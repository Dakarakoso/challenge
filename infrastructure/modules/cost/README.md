## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_budgets_budget.monthly](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/budgets_budget) | resource |
| [aws_cloudwatch_event_rule.cost_anomaly](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_target.cost_anomaly_to_sns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |
| [aws_cur_report_definition.daily](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cur_report_definition) | resource |
| [aws_s3_bucket.cur](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_lifecycle_configuration.cur](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration) | resource |
| [aws_s3_bucket_versioning.cur](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |
| [aws_sns_topic.cost_alerts](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic) | resource |
| [aws_sns_topic_policy.cost_alerts_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_policy) | resource |
| [aws_iam_policy_document.events_to_sns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alert_email"></a> [alert\_email](#input\_alert\_email) | Email for budget and anomaly notifications | `string` | n/a | yes |
| <a name="input_anomaly_threshold_amount"></a> [anomaly\_threshold\_amount](#input\_anomaly\_threshold\_amount) | Absolute JPY threshold for anomaly alerts | `number` | `20000` | no |
| <a name="input_budget_threshold_amount"></a> [budget\_threshold\_amount](#input\_budget\_threshold\_amount) | Alert threshold as percentage of JPY budget | `number` | `80` | no |
| <a name="input_cur_s3_bucket"></a> [cur\_s3\_bucket](#input\_cur\_s3\_bucket) | S3 bucket to receive CUR files (must exist) | `string` | n/a | yes |
| <a name="input_monthly_budget_limit"></a> [monthly\_budget\_limit](#input\_monthly\_budget\_limit) | Budget limit in JPY | `number` | `100000` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Name prefix | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | AWS region for CUR bucket & budgets | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_anomaly_rule_arn"></a> [anomaly\_rule\_arn](#output\_anomaly\_rule\_arn) | ARN of the EventBridge rule for cost anomalies |
| <a name="output_budget_name"></a> [budget\_name](#output\_budget\_name) | Name of the monthly budget |
| <a name="output_cur_bucket"></a> [cur\_bucket](#output\_cur\_bucket) | Name of the CUR S3 bucket |
