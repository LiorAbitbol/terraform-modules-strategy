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

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket_arn"></a> [bucket\_arn](#output\_bucket\_arn) | ARN of the S3 bucket. |
| <a name="output_bucket_domain_name"></a> [bucket\_domain\_name](#output\_bucket\_domain\_name) | Domain name of the S3 bucket. |
| <a name="output_bucket_id"></a> [bucket\_id](#output\_bucket\_id) | ID (name) of the S3 bucket. |
| <a name="output_bucket_regional_domain_name"></a> [bucket\_regional\_domain\_name](#output\_bucket\_regional\_domain\_name) | Regional domain name of the S3 bucket. |
<!-- END_TF_DOCS -->