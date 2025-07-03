## Requirements

No requirements.

## Providers

| Name                                             | Version |
| ------------------------------------------------ | ------- |
| <a name="provider_aws"></a> [aws](#provider_aws) | n/a     |

## Modules

No modules.

## Resources

| Name                                                                                                                                       | Type     |
| ------------------------------------------------------------------------------------------------------------------------------------------ | -------- |
| [aws_alb.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/alb)                                            | resource |
| [aws_alb_listener.https](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/alb_listener)                         | resource |
| [aws_alb_target_group.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/alb_target_group)                  | resource |
| [aws_db_subnet_group.db](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group)                      | resource |
| [aws_eip.nat](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip)                                             | resource |
| [aws_flow_log.vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/flow_log)                                   | resource |
| [aws_internet_gateway.igw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway)                   | resource |
| [aws_nat_gateway.nat](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway)                             | resource |
| [aws_route_table.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table)                         | resource |
| [aws_route_table.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table)                          | resource |
| [aws_route_table_association.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association)  | resource |
| [aws_security_group.alb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group)                       | resource |
| [aws_subnet.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet)                                   | resource |
| [aws_subnet.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet)                                    | resource |
| [aws_vpc.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc)                                            | resource |

## Inputs

| Name                                                                                                | Description                                | Type           | Default | Required |
| --------------------------------------------------------------------------------------------------- | ------------------------------------------ | -------------- | ------- | :------: |
| <a name="input_acm_certificate_arn"></a> [acm_certificate_arn](#input_acm_certificate_arn)          | ACM certificate ARN for HTTPS              | `string`       | n/a     |   yes    |
| <a name="input_azs"></a> [azs](#input_azs)                                                          | Availability zones                         | `list(string)` | n/a     |   yes    |
| <a name="input_log_group_arn"></a> [log_group_arn](#input_log_group_arn)                            | CloudWatch Log Group ARN for VPC Flow Logs | `string`       | n/a     |   yes    |
| <a name="input_private_subnets"></a> [private_subnets](#input_private_subnets)                      | List of private subnet CIDRs               | `list(string)` | n/a     |   yes    |
| <a name="input_public_subnets"></a> [public_subnets](#input_public_subnets)                         | List of public subnet CIDRs                | `list(string)` | n/a     |   yes    |
| <a name="input_vpc_cidr"></a> [vpc_cidr](#input_vpc_cidr)                                           | CIDR block for the VPC                     | `string`       | n/a     |   yes    |
| <a name="input_vpc_flow_logs_role_arn"></a> [vpc_flow_logs_role_arn](#input_vpc_flow_logs_role_arn) | IAM role ARN to use for VPC Flow Logs      | `string`       | n/a     |   yes    |

## Outputs

| Name                                                                                            | Description |
| ----------------------------------------------------------------------------------------------- | ----------- |
| <a name="output_alb_dns_name"></a> [alb_dns_name](#output_alb_dns_name)                         | n/a         |
| <a name="output_alb_sg_id"></a> [alb_sg_id](#output_alb_sg_id)                                  | n/a         |
| <a name="output_alb_target_group_arn"></a> [alb_target_group_arn](#output_alb_target_group_arn) | n/a         |
| <a name="output_db_subnet_group"></a> [db_subnet_group](#output_db_subnet_group)                | n/a         |
| <a name="output_private_subnets"></a> [private_subnets](#output_private_subnets)                | n/a         |
| <a name="output_public_subnets"></a> [public_subnets](#output_public_subnets)                   | n/a         |
| <a name="output_vpc_id"></a> [vpc_id](#output_vpc_id)                                           | n/a         |
