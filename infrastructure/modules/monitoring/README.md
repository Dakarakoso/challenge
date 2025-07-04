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
| [aws_cloudwatch_log_group.flow_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_metric_alarm.alb_5xx](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.backup_failure](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.ecs_cpu](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.ecs_memory](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.rds_cpu](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_sns_topic.alarms](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic) | resource |
| [aws_sns_topic_subscription.email](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alarm_email"></a> [alarm\_email](#input\_alarm\_email) | Email for alarm notifications | `string` | n/a | yes |
| <a name="input_alb_arn_suffix"></a> [alb\_arn\_suffix](#input\_alb\_arn\_suffix) | ALB ARN suffix | `string` | n/a | yes |
| <a name="input_db_instance_id"></a> [db\_instance\_id](#input\_db\_instance\_id) | RDS instance ID | `string` | n/a | yes |
| <a name="input_ecs_cluster_name"></a> [ecs\_cluster\_name](#input\_ecs\_cluster\_name) | ECS cluster name | `string` | n/a | yes |
| <a name="input_ecs_service_name"></a> [ecs\_service\_name](#input\_ecs\_service\_name) | ECS service name | `string` | n/a | yes |
| <a name="input_pipeline_name"></a> [pipeline\_name](#input\_pipeline\_name) | Pipeline Name | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Resource name prefix | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alarm_topic_arn"></a> [alarm\_topic\_arn](#output\_alarm\_topic\_arn) | n/a |
| <a name="output_alb_5xx_alarm_name"></a> [alb\_5xx\_alarm\_name](#output\_alb\_5xx\_alarm\_name) | Name of the ALB 5XX CloudWatch alarm |
| <a name="output_ecs_cpu_alarm_name"></a> [ecs\_cpu\_alarm\_name](#output\_ecs\_cpu\_alarm\_name) | Name of the ECS high-CPU alarm |
| <a name="output_ecs_memory_alarm_name"></a> [ecs\_memory\_alarm\_name](#output\_ecs\_memory\_alarm\_name) | Name of the ECS high-memory alarm |
| <a name="output_flow_logs_log_group_arn"></a> [flow\_logs\_log\_group\_arn](#output\_flow\_logs\_log\_group\_arn) | The ARN of the log group used for VPC flow logs |
| <a name="output_rds_cpu_alarm_name"></a> [rds\_cpu\_alarm\_name](#output\_rds\_cpu\_alarm\_name) | Name of the RDS high-CPU alarm |
| <a name="output_vpc_flow_log_group"></a> [vpc\_flow\_log\_group](#output\_vpc\_flow\_log\_group) | n/a |
