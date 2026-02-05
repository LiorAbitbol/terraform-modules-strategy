# SNS Topic (Foundation)

Creates an AWS SNS (Simple Notification Service) topic for pub/sub messaging.

This is a **foundation module**: it provides a reusable SNS topic primitive. Subscriptions
and message publishing should be handled separately or in **pattern modules**.

## Usage

```hcl
module "alerts_topic" {
  source = "../../modules/foundation/sns-topic"

  name        = "alerts"
  display_name = "System Alerts"

  kms_key_id = "arn:aws:kms:us-east-1:123456789012:key/12345678-1234-1234-1234-123456789012"

  tags = {
    Environment = "prod"
    Owner       = "platform"
    Purpose     = "alerts"
  }
}

# FIFO topic example
module "order_events" {
  source = "../../modules/foundation/sns-topic"

  name                        = "order-events.fifo"
  fifo_topic                  = true
  content_based_deduplication = true

  tags = {
    Environment = "prod"
    Owner       = "platform"
  }
}
```

## Notes

- FIFO topics require `.fifo` suffix in the name.
- Content-based deduplication helps prevent duplicate messages in FIFO topics.
- KMS encryption is recommended for sensitive notifications.
- Subscriptions (email, SMS, SQS, Lambda, etc.) should be created separately.
- Display name is used for email subscriptions to identify the sender.

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
| [aws_sns_topic.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_content_based_deduplication"></a> [content\_based\_deduplication](#input\_content\_based\_deduplication) | Enable content-based deduplication for FIFO topics. | `bool` | `false` | no |
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | Display name for the SNS topic (for email subscriptions). | `string` | `null` | no |
| <a name="input_fifo_topic"></a> [fifo\_topic](#input\_fifo\_topic) | Whether this is a FIFO topic (first-in-first-out delivery). | `bool` | `false` | no |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | ARN of the KMS key for encrypting messages. If not provided, SNS managed encryption is used. | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the SNS topic. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags to apply to all resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_topic_arn"></a> [topic\_arn](#output\_topic\_arn) | ARN of the SNS topic. |
| <a name="output_topic_name"></a> [topic\_name](#output\_topic\_name) | Name of the SNS topic. |
<!-- END_TF_DOCS -->
