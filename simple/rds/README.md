<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.0.0 |
| <a name="provider_aws.cross_region_replication"></a> [aws.cross\_region\_replication](#provider\_aws.cross\_region\_replication) | >= 3.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_metric_alarm.cpu-usage](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.cpu-usage-reader](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.free-space](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.free-space-reader](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_db_instance.cross_region_read_replica](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance) | resource |
| [aws_db_instance.new_public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance) | resource |
| [aws_db_instance.read_replica](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance) | resource |
| [aws_db_parameter_group.cross_region_postgres14](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_parameter_group) | resource |
| [aws_db_parameter_group.cross_region_postgres15](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_parameter_group) | resource |
| [aws_db_parameter_group.cross_region_ssl_param_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_parameter_group) | resource |
| [aws_db_parameter_group.postgres14](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_parameter_group) | resource |
| [aws_db_parameter_group.postgres15](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_parameter_group) | resource |
| [aws_db_parameter_group.ssl_param_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_parameter_group) | resource |
| [aws_db_subnet_group.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group) | resource |
| [aws_db_subnet_group.default_cross_region](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group) | resource |
| [aws_db_subnet_group.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group) | resource |
| [aws_db_subnet_group.public_cross_region](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group) | resource |
| [aws_secretsmanager_secret_version.credentials](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret_version) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_availability_zone"></a> [availability\_zone](#input\_availability\_zone) | n/a | `string` | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | n/a | `string` | n/a | yes |
| <a name="input_company_name"></a> [company\_name](#input\_company\_name) | n/a | `string` | n/a | yes |
| <a name="input_cross_region_kms_key_arn"></a> [cross\_region\_kms\_key\_arn](#input\_cross\_region\_kms\_key\_arn) | n/a | `string` | `""` | no |
| <a name="input_cross_region_private_subnets"></a> [cross\_region\_private\_subnets](#input\_cross\_region\_private\_subnets) | n/a | `list(string)` | `[]` | no |
| <a name="input_cross_region_public_subnets"></a> [cross\_region\_public\_subnets](#input\_cross\_region\_public\_subnets) | n/a | `list(string)` | `[]` | no |
| <a name="input_cross_region_security_group"></a> [cross\_region\_security\_group](#input\_cross\_region\_security\_group) | n/a | `string` | `""` | no |
| <a name="input_database_max_allocated_storage"></a> [database\_max\_allocated\_storage](#input\_database\_max\_allocated\_storage) | n/a | `number` | `200` | no |
| <a name="input_deploy_cross_region_read_replica"></a> [deploy\_cross\_region\_read\_replica](#input\_deploy\_cross\_region\_read\_replica) | Whether to add a cross region read replica | `bool` | `false` | no |
| <a name="input_deploy_read_replica"></a> [deploy\_read\_replica](#input\_deploy\_read\_replica) | Whether to add a read replica | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `string` | n/a | yes |
| <a name="input_initial_database"></a> [initial\_database](#input\_initial\_database) | n/a | `string` | n/a | yes |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | n/a | `string` | `"db.t3.xlarge"` | no |
| <a name="input_kms_key_arn"></a> [kms\_key\_arn](#input\_kms\_key\_arn) | n/a | `string` | n/a | yes |
| <a name="input_name_override"></a> [name\_override](#input\_name\_override) | This is a workaround for incompatibility for two stacks that use this module, ecs-app and eks-app | `string` | `"new-public"` | no |
| <a name="input_parameter_group_major_version"></a> [parameter\_group\_major\_version](#input\_parameter\_group\_major\_version) | The major version of the parameter group. Ex. 14, 15 | `string` | `"14"` | no |
| <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | n/a | `list(string)` | n/a | yes |
| <a name="input_public_subnets"></a> [public\_subnets](#input\_public\_subnets) | n/a | `list(string)` | n/a | yes |
| <a name="input_rds_auto_minor_version_upgrade"></a> [rds\_auto\_minor\_version\_upgrade](#input\_rds\_auto\_minor\_version\_upgrade) | n/a | `bool` | `false` | no |
| <a name="input_rds_engine_version"></a> [rds\_engine\_version](#input\_rds\_engine\_version) | n/a | `string` | `"11.13"` | no |
| <a name="input_reader_instance_type"></a> [reader\_instance\_type](#input\_reader\_instance\_type) | n/a | `string` | `"db.t3.xlarge"` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | n/a | yes |
| <a name="input_role_arn"></a> [role\_arn](#input\_role\_arn) | n/a | `string` | n/a | yes |
| <a name="input_security_group"></a> [security\_group](#input\_security\_group) | n/a | `string` | n/a | yes |
| <a name="input_skip_final_snapshot"></a> [skip\_final\_snapshot](#input\_skip\_final\_snapshot) | n/a | `bool` | `false` | no |
| <a name="input_snapshot_identifier"></a> [snapshot\_identifier](#input\_snapshot\_identifier) | n/a | `string` | `""` | no |
| <a name="input_sns_arn"></a> [sns\_arn](#input\_sns\_arn) | n/a | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(any)` | n/a | yes |
| <a name="input_use_only_private_subnets"></a> [use\_only\_private\_subnets](#input\_use\_only\_private\_subnets) | If true, will use only private subnets | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_address"></a> [address](#output\_address) | n/a |
| <a name="output_port"></a> [port](#output\_port) | n/a |
| <a name="output_rds_deletion_protection"></a> [rds\_deletion\_protection](#output\_rds\_deletion\_protection) | n/a |
<!-- END_TF_DOCS -->