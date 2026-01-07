# App Network (Pattern)

Opinionated network baseline for an application.

This pattern composes:
- `foundation/vpc`
- `foundation/security-group` (default app ingress/egress rules)

## Usage

```hcl
module "app_network" {
  source = "../../modules/patterns/app-network"

  name           = "dev-app"
  vpc_cidr_block = "10.10.0.0/16"

  azs                 = ["us-east-1a", "us-east-1b"]
  public_subnet_cidrs  = ["10.10.0.0/24", "10.10.1.0/24"]
  private_subnet_cidrs = ["10.10.10.0/24", "10.10.11.0/24"]

  allowed_ingress_cidr_blocks = ["10.0.0.0/8"]
  app_ingress_ports           = [443]

  tags = {
    Environment = "dev"
    Owner       = "platform"
  }
}
```

## Notes
- This is a pattern module: it encodes conventions and reduces caller complexity.
- It creates a default application security group. If you need multiple SGs or more granular policies, create additional pattern modules.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_app_security_group"></a> [app\_security\_group](#module\_app\_security\_group) | ../../foundation/security-group | n/a |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | ../../foundation/vpc | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_ingress_cidr_blocks"></a> [allowed\_ingress\_cidr\_blocks](#input\_allowed\_ingress\_cidr\_blocks) | CIDR blocks allowed to ingress to the default app security group. | `list(string)` | `[]` | no |
| <a name="input_app_ingress_ports"></a> [app\_ingress\_ports](#input\_app\_ingress\_ports) | TCP ports allowed for ingress to the default app security group. | `list(number)` | <pre>[<br>  443<br>]</pre> | no |
| <a name="input_azs"></a> [azs](#input\_azs) | List of availability zones to use. | `list(string)` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Base name used for resources created by this pattern. | `string` | n/a | yes |
| <a name="input_private_subnet_cidrs"></a> [private\_subnet\_cidrs](#input\_private\_subnet\_cidrs) | CIDR blocks for private subnets (one per AZ). | `list(string)` | n/a | yes |
| <a name="input_public_subnet_cidrs"></a> [public\_subnet\_cidrs](#input\_public\_subnet\_cidrs) | CIDR blocks for public subnets (one per AZ). | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Base tags applied to all resources. | `map(string)` | `{}` | no |
| <a name="input_vpc_cidr_block"></a> [vpc\_cidr\_block](#input\_vpc\_cidr\_block) | CIDR block for the VPC. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_app_security_group_id"></a> [app\_security\_group\_id](#output\_app\_security\_group\_id) | ID of the default application security group. |
| <a name="output_private_subnet_ids"></a> [private\_subnet\_ids](#output\_private\_subnet\_ids) | IDs of private subnets. |
| <a name="output_public_subnet_ids"></a> [public\_subnet\_ids](#output\_public\_subnet\_ids) | IDs of public subnets. |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | ID of the VPC. |
<!-- END_TF_DOCS -->