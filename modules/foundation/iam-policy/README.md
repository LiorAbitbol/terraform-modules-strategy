# IAM Policy (Foundation)

Creates an AWS IAM policy that can be attached to roles or users.

This is a **foundation module**: it provides a reusable IAM policy primitive for
creating customer-managed policies. Higher-level permission patterns should be
implemented in **pattern modules**.

## Usage

```hcl
module "s3_read_policy" {
  source = "../../modules/foundation/iam-policy"

  name        = "s3-read-only-policy"
  description = "Policy for read-only access to specific S3 bucket"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:ListBucket"
        ]
        Resource = [
          "arn:aws:s3:::my-bucket",
          "arn:aws:s3:::my-bucket/*"
        ]
      }
    ]
  })

  tags = {
    Environment = "dev"
    Owner       = "platform"
  }
}
```

## Notes

- This creates a customer-managed policy that can be attached to multiple roles or users.
- Policies are reusable across multiple IAM entities.
- Use this for common permission patterns that need to be shared.
- The policy document must be valid JSON.

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
| [aws_iam_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | Description of the IAM policy. | `string` | `"Managed by Terraform"` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the IAM policy. | `string` | n/a | yes |
| <a name="input_policy"></a> [policy](#input\_policy) | JSON policy document for the IAM policy. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags to apply to all resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_policy_arn"></a> [policy\_arn](#output\_policy\_arn) | ARN of the IAM policy. |
| <a name="output_policy_id"></a> [policy\_id](#output\_policy\_id) | ID of the IAM policy. |
| <a name="output_policy_name"></a> [policy\_name](#output\_policy\_name) | Name of the IAM policy. |
<!-- END_TF_DOCS -->
