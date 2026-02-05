# KMS Key (Foundation)

Creates an AWS KMS key for encryption with optional aliases and key rotation.

This is a **foundation module**: it provides a reusable KMS key primitive with secure
defaults. Higher-level encryption patterns should be implemented in **pattern modules**.

## Usage

```hcl
module "s3_encryption_key" {
  source = "../../modules/foundation/kms-key"

  name        = "s3-encryption-key"
  description = "KMS key for S3 bucket encryption"

  enable_key_rotation = true
  multi_region       = false

  aliases = ["s3-encryption"]

  tags = {
    Environment = "dev"
    Owner       = "platform"
    Purpose     = "s3-encryption"
  }
}
```

## Notes

- Key rotation is enabled by default (security best practice).
- Deletion window defaults to 30 days to prevent accidental key deletion.
- Aliases provide a friendly way to reference keys (e.g., `alias/my-key`).
- Default policy allows the root account to manage the key. Provide a custom policy for more restrictive access.
- Multi-region keys can be used for cross-region replication scenarios.

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
| [aws_kms_alias.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_key.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aliases"></a> [aliases](#input\_aliases) | List of aliases to create for the key. | `list(string)` | `[]` | no |
| <a name="input_customer_master_key_spec"></a> [customer\_master\_key\_spec](#input\_customer\_master\_key\_spec) | Specifies whether the key contains a symmetric key or an asymmetric key pair. Valid values: SYMMETRIC\_DEFAULT, RSA\_2048, RSA\_3072, RSA\_4096, ECC\_NIST\_P256, ECC\_NIST\_P384, ECC\_NIST\_P521, ECC\_SECG\_P256K1. | `string` | `"SYMMETRIC_DEFAULT"` | no |
| <a name="input_deletion_window_in_days"></a> [deletion\_window\_in\_days](#input\_deletion\_window\_in\_days) | Number of days to wait before deleting the key (7-30). | `number` | `30` | no |
| <a name="input_description"></a> [description](#input\_description) | Description of the KMS key. | `string` | `"Managed by Terraform"` | no |
| <a name="input_enable_key_rotation"></a> [enable\_key\_rotation](#input\_enable\_key\_rotation) | Enable automatic key rotation. | `bool` | `true` | no |
| <a name="input_key_usage"></a> [key\_usage](#input\_key\_usage) | Intended use of the key. Valid values: ENCRYPT\_DECRYPT, SIGN\_VERIFY. | `string` | `"ENCRYPT_DECRYPT"` | no |
| <a name="input_multi_region"></a> [multi\_region](#input\_multi\_region) | Whether the key is a multi-region key. | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | Display name for the KMS key. | `string` | n/a | yes |
| <a name="input_policy"></a> [policy](#input\_policy) | IAM policy document for the key. If not provided, a default policy will be created that allows the root account to manage the key. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags to apply to all resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_key_alias_arns"></a> [key\_alias\_arns](#output\_key\_alias\_arns) | ARNs of the KMS key aliases. |
| <a name="output_key_arn"></a> [key\_arn](#output\_key\_arn) | ARN of the KMS key. |
| <a name="output_key_id"></a> [key\_id](#output\_key\_id) | Globally unique identifier for the KMS key. |
<!-- END_TF_DOCS -->
