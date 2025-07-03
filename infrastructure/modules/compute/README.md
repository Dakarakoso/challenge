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
| [aws_appautoscaling_policy.server_scale_cpu](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_policy) | resource |
| [aws_appautoscaling_target.server_scale](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_target) | resource |
| [aws_cloudwatch_log_group.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_ecs_cluster.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster) | resource |
| [aws_ecs_service.server](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service) | resource |
| [aws_ecs_service.worker](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service) | resource |
| [aws_ecs_task_definition.server](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |
| [aws_ecs_task_definition.worker](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alb_target_group_arn"></a> [alb\_target\_group\_arn](#input\_alb\_target\_group\_arn) | ALB target group ARN | `string` | n/a | yes |
| <a name="input_app_secret_arn"></a> [app\_secret\_arn](#input\_app\_secret\_arn) | App secret ARN | `string` | n/a | yes |
| <a name="input_cloudwatch_log_group"></a> [cloudwatch\_log\_group](#input\_cloudwatch\_log\_group) | CloudWatch log group name | `string` | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | ECS cluster name | `string` | n/a | yes |
| <a name="input_db_endpoint"></a> [db\_endpoint](#input\_db\_endpoint) | Database endpoint | `string` | n/a | yes |
| <a name="input_db_name"></a> [db\_name](#input\_db\_name) | Database name | `string` | n/a | yes |
| <a name="input_db_username"></a> [db\_username](#input\_db\_username) | Database username | `string` | n/a | yes |
| <a name="input_ecs_security_group_id"></a> [ecs\_security\_group\_id](#input\_ecs\_security\_group\_id) | ECS security group ID | `string` | n/a | yes |
| <a name="input_execution_role_arn"></a> [execution\_role\_arn](#input\_execution\_role\_arn) | ECS execution role ARN | `string` | n/a | yes |
| <a name="input_kms_key_arn"></a> [kms\_key\_arn](#input\_kms\_key\_arn) | KMS key ARN | `string` | n/a | yes |
| <a name="input_pgpassword_secret_arn"></a> [pgpassword\_secret\_arn](#input\_pgpassword\_secret\_arn) | Database password secret ARN | `string` | n/a | yes |
| <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | Private subnets for ECS | `list(string)` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | AWS region | `string` | n/a | yes |
| <a name="input_s3_bucket_name"></a> [s3\_bucket\_name](#input\_s3\_bucket\_name) | S3 bucket name | `string` | n/a | yes |
| <a name="input_server_container_port"></a> [server\_container\_port](#input\_server\_container\_port) | Server container port | `number` | `3000` | no |
| <a name="input_server_cpu"></a> [server\_cpu](#input\_server\_cpu) | Server CPU units | `number` | `512` | no |
| <a name="input_server_desired_count"></a> [server\_desired\_count](#input\_server\_desired\_count) | Server desired count | `number` | `2` | no |
| <a name="input_server_image"></a> [server\_image](#input\_server\_image) | Server container image | `string` | n/a | yes |
| <a name="input_server_max_capacity"></a> [server\_max\_capacity](#input\_server\_max\_capacity) | Server max capacity | `number` | `10` | no |
| <a name="input_server_memory"></a> [server\_memory](#input\_server\_memory) | Server memory (MB) | `number` | `1024` | no |
| <a name="input_server_min_capacity"></a> [server\_min\_capacity](#input\_server\_min\_capacity) | Server min capacity | `number` | `2` | no |
| <a name="input_server_url"></a> [server\_url](#input\_server\_url) | Application server URL | `string` | n/a | yes |
| <a name="input_task_role_arn"></a> [task\_role\_arn](#input\_task\_role\_arn) | ECS task role ARN | `string` | n/a | yes |
| <a name="input_worker_cpu"></a> [worker\_cpu](#input\_worker\_cpu) | Worker CPU units | `number` | `256` | no |
| <a name="input_worker_desired_count"></a> [worker\_desired\_count](#input\_worker\_desired\_count) | Worker desired count | `number` | `1` | no |
| <a name="input_worker_image"></a> [worker\_image](#input\_worker\_image) | Worker container image | `string` | n/a | yes |
| <a name="input_worker_memory"></a> [worker\_memory](#input\_worker\_memory) | Worker memory (MB) | `number` | `512` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | n/a |
| <a name="output_log_group_name"></a> [log\_group\_name](#output\_log\_group\_name) | n/a |
| <a name="output_server_service_name"></a> [server\_service\_name](#output\_server\_service\_name) | n/a |
| <a name="output_worker_service_name"></a> [worker\_service\_name](#output\_worker\_service\_name) | n/a |
