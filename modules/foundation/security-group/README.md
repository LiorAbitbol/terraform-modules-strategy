# Security Group (Foundation)

Creates an AWS Security Group and optional ingress/egress rules.

## Usage

```hcl
module "sg" {
  source = "../../modules/foundation/security-group"

  name   = "example-sg"
  vpc_id = "vpc-1234567890abcdef0"

  rules = [
    {
      type        = "ingress"
      protocol    = "tcp"
      from_port   = 443
      to_port     = 443
      cidr_blocks = ["10.0.0.0/16"]
      description = "Allow HTTPS from VPC"
    },
    {
      type        = "egress"
      protocol    = "-1"
      from_port   = 0
      to_port     = 0
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow all outbound"
    }
  ]

  tags = {
    Environment = "dev"
  }
}
```

## Notes
- Rules are managed using aws_security_group_rule resources for clean diffs.
- If security_groups is provided in a rule, only the first element is used as source_security_group_id.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.31.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | Description for the security group. | `string` | `"Managed by Terraform"` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the security group. | `string` | n/a | yes |
| <a name="input_rules"></a> [rules](#input\_rules) | List of security group rules.<br><br>Each rule supports:<br>- type: "ingress" or "egress"<br>- protocol: "tcp", "udp", "-1" (all), etc.<br>- from\_port/to\_port: required unless protocol is "-1"<br>- cidr\_block / ipv6\_cidr\_block / prefix\_list\_ids / security\_groups: optional source/destination<br>- description: optional | <pre>list(object({<br>    type            = string<br>    protocol        = string<br>    from_port       = number<br>    to_port         = number<br>    cidr_blocks     = optional(list(string), [])<br>    ipv6_cidr_block = optional(list(string), [])<br>    prefix_list_ids = optional(list(string), [])<br>    security_groups = optional(list(string), [])<br>    self            = optional(bool, null)<br>    description     = optional(string, null)<br>  }))</pre> | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags to apply to all resources. | `map(string)` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID where the security group will be created. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_security_group_arn"></a> [security\_group\_arn](#output\_security\_group\_arn) | ARN of the security group. |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | ID of the security group. |
<!-- END_TF_DOCS -->