# S3 Bucket (Foundation)

Creates an AWS S3 bucket with security best practices, encryption, versioning, and lifecycle management.

This is a **foundation module**: it provides a reusable S3 bucket primitive with secure
defaults. Higher-level bucket patterns (e.g., logging buckets, application buckets)
should be implemented in **pattern modules**.

## Usage

```hcl
module "app_bucket" {
  source = "../../modules/foundation/s3-bucket"

  name      = "my-unique-bucket-name"
  versioning = true

  encryption_enabled = true
  kms_key_id        = "arn:aws:kms:us-east-1:123456789012:key/12345678-1234-1234-1234-123456789012"

  lifecycle_rules = [
    {
      id      = "delete-old-logs"
      enabled = true
      prefix  = "logs/"
      expiration_days = 90
    },
    {
      id      = "transition-to-glacier"
      enabled = true
      prefix  = "archive/"
      transition_days         = 30
      transition_storage_class = "GLACIER"
    }
  ]

  logging_enabled      = true
  logging_target_bucket = "my-logs-bucket"
  logging_target_prefix = "app-bucket-logs/"

  tags = {
    Environment = "dev"
    Owner       = "platform"
  }
}
```

## Notes

- Bucket names must be globally unique across all AWS accounts.
- Public access is blocked by default (security best practice).
- Encryption is enabled by default (AES256). Provide `kms_key_id` for KMS encryption.
- Lifecycle rules support expiration and transitions to different storage classes.
- Access logging can be enabled to track bucket access patterns.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_s3_bucket.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_lifecycle_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration) | resource |
| [aws_s3_bucket_logging.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_logging) | resource |
| [aws_s3_bucket_public_access_block.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_versioning.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_block_public_acls"></a> [block\_public\_acls](#input\_block\_public\_acls) | Block public ACLs on the bucket. | `bool` | `true` | no |
| <a name="input_block_public_policy"></a> [block\_public\_policy](#input\_block\_public\_policy) | Block public bucket policies. | `bool` | `true` | no |
| <a name="input_encryption_enabled"></a> [encryption\_enabled](#input\_encryption\_enabled) | Enable server-side encryption for the bucket. | `bool` | `true` | no |
| <a name="input_ignore_public_acls"></a> [ignore\_public\_acls](#input\_ignore\_public\_acls) | Ignore public ACLs on the bucket. | `bool` | `true` | no |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | KMS key ID for encryption. If not provided, AWS managed encryption (AES256) is used. | `string` | `null` | no |
| <a name="input_lifecycle_rules"></a> [lifecycle\_rules](#input\_lifecycle\_rules) | List of lifecycle rules for the bucket.<br><br>Each rule supports:<br>- id: unique identifier for the rule<br>- enabled: whether the rule is enabled<br>- prefix: object key prefix filter (optional)<br>- expiration\_days: number of days until objects expire (optional)<br>- transition\_days: number of days until transition (optional)<br>- transition\_storage\_class: storage class to transition to (optional) | <pre>list(object({<br>    id                       = string<br>    enabled                  = bool<br>    prefix                   = optional(string, null)<br>    expiration_days          = optional(number, null)<br>    transition_days          = optional(number, null)<br>    transition_storage_class = optional(string, null)<br>  }))</pre> | `[]` | no |
| <a name="input_logging_enabled"></a> [logging\_enabled](#input\_logging\_enabled) | Enable access logging for the bucket. | `bool` | `false` | no |
| <a name="input_logging_target_bucket"></a> [logging\_target\_bucket](#input\_logging\_target\_bucket) | Target bucket for access logs. Required if logging\_enabled is true. | `string` | `null` | no |
| <a name="input_logging_target_prefix"></a> [logging\_target\_prefix](#input\_logging\_target\_prefix) | Prefix for access log object keys. | `string` | `"logs/"` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the S3 bucket. Must be globally unique. | `string` | n/a | yes |
| <a name="input_restrict_public_buckets"></a> [restrict\_public\_buckets](#input\_restrict\_public\_buckets) | Restrict public bucket policies. | `bool` | `true` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags to apply to all resources. | `map(string)` | `{}` | no |
| <a name="input_versioning"></a> [versioning](#input\_versioning) | Enable versioning for the bucket. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket_arn"></a> [bucket\_arn](#output\_bucket\_arn) | ARN of the S3 bucket. |
| <a name="output_bucket_domain_name"></a> [bucket\_domain\_name](#output\_bucket\_domain\_name) | Domain name of the S3 bucket. |
| <a name="output_bucket_id"></a> [bucket\_id](#output\_bucket\_id) | ID (name) of the S3 bucket. |
| <a name="output_bucket_regional_domain_name"></a> [bucket\_regional\_domain\_name](#output\_bucket\_regional\_domain\_name) | Regional domain name of the S3 bucket. |
<!-- END_TF_DOCS -->