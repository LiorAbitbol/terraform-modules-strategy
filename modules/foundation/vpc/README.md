# VPC (Foundation)

Creates an AWS VPC with public and private subnets.

This is a **foundation module**: it provides low-level networking primitives with
minimal opinions and safe defaults. Higher-level routing, NAT, and application
conventions should be implemented in **pattern modules**.

## Usage

```hcl
module "vpc" {
  source = "../../modules/foundation/vpc"

  name                = "example"
  cidr_block          = "10.0.0.0/16"
  azs                 = ["us-east-1a", "us-east-1b"]
  public_subnet_cidrs  = ["10.0.0.0/24", "10.0.1.0/24"]
  private_subnet_cidrs = ["10.0.10.0/24", "10.0.11.0/24"]

  tags = {
    Environment = "dev"
    Owner       = "platform"
  }
}
```

## Notes

- One public and one private subnet are created per availability zone.
- Internet Gateway is created and attached to the VPC.
- NAT gateways and route tables are intentionally excluded.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.27.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_internet_gateway.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_subnet.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_azs"></a> [azs](#input\_azs) | List of availablity zones to use. | `list(string)` | n/a | yes |
| <a name="input_cidr_block"></a> [cidr\_block](#input\_cidr\_block) | CIDR block for the VPC. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Base name used for VPC and related resources. | `string` | n/a | yes |
| <a name="input_private_subnet_cidr"></a> [private\_subnet\_cidr](#input\_private\_subnet\_cidr) | CIDR blocks for private subnets (one per AZ). | `list(string)` | n/a | yes |
| <a name="input_public_subnet_cidr"></a> [public\_subnet\_cidr](#input\_public\_subnet\_cidr) | CIDR blocks for public subnets (one per AZ). | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags to apply to all resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_private_subnet_ids"></a> [private\_subnet\_ids](#output\_private\_subnet\_ids) | IDs of private subnets. |
| <a name="output_public_subnet_ids"></a> [public\_subnet\_ids](#output\_public\_subnet\_ids) | IDs of public subnets. |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | ID for the VPC. |
<!-- END_TF_DOCS -->