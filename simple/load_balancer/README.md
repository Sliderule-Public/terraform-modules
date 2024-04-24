# load_balancer


<!-- BEGIN_TF_DOCS -->
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
| [aws_lb.load_balancer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_lb_listener.http](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_listener.https](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_log_bucket"></a> [access\_log\_bucket](#input\_access\_log\_bucket) | n/a | `string` | `""` | no |
| <a name="input_cert_arn"></a> [cert\_arn](#input\_cert\_arn) | n/a | `string` | n/a | yes |
| <a name="input_company_name"></a> [company\_name](#input\_company\_name) | n/a | `string` | n/a | yes |
| <a name="input_enable_access_logs"></a> [enable\_access\_logs](#input\_enable\_access\_logs) | n/a | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `string` | n/a | yes |
| <a name="input_idle_timeout"></a> [idle\_timeout](#input\_idle\_timeout) | n/a | `number` | `60` | no |
| <a name="input_internal"></a> [internal](#input\_internal) | n/a | `bool` | `false` | no |
| <a name="input_load_balancer_name"></a> [load\_balancer\_name](#input\_load\_balancer\_name) | n/a | `string` | n/a | yes |
| <a name="input_security_group_id"></a> [security\_group\_id](#input\_security\_group\_id) | n/a | `string` | n/a | yes |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | n/a | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(any)` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dns_name"></a> [dns\_name](#output\_dns\_name) | n/a |
| <a name="output_lb"></a> [lb](#output\_lb) | n/a |
| <a name="output_lb_arn"></a> [lb\_arn](#output\_lb\_arn) | n/a |
| <a name="output_lb_hosted_zone"></a> [lb\_hosted\_zone](#output\_lb\_hosted\_zone) | n/a |
| <a name="output_listener_arn"></a> [listener\_arn](#output\_listener\_arn) | n/a |
<!-- END_TF_DOCS -->
