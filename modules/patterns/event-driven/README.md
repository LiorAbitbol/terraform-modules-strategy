# Event-Driven Architecture (Pattern)

Creates a complete event-driven messaging infrastructure with SNS topic, SQS queue, dead letter queue, and automatic subscription.

This is a **pattern module**: it combines foundation modules (SNS, SQS, IAM Policy) to provide an
opinionated, production-ready pub/sub solution with dead letter handling, encryption, and
automatic topic-to-queue subscription.

## Usage

```hcl
# Standard event-driven pattern
module "order_events" {
  source = "../../modules/patterns/event-driven"

  name = "order-events"

  max_receive_count          = 5
  visibility_timeout_seconds = 60

  kms_key_id = "arn:aws:kms:us-east-1:123456789012:key/12345678-1234-1234-1234-123456789012"

  tags = {
    Environment = "prod"
    Owner       = "platform"
  }
}

# FIFO event-driven pattern (ordered, exactly-once delivery)
module "payment_events" {
  source = "../../modules/patterns/event-driven"

  name        = "payment-events"
  fifo_enabled = true

  max_receive_count          = 3
  visibility_timeout_seconds = 30

  tags = {
    Environment = "prod"
    Owner       = "platform"
  }
}
```

## What This Creates

- **SNS Topic**: Pub/sub topic for publishing events
- **SQS Queue**: Message queue for consuming events
- **Dead Letter Queue**: Automatic DLQ for failed message processing
- **IAM Policy**: Policy for SQS subscription and message handling
- **SNS Subscription**: Automatic subscription of SQS queue to SNS topic

## Features

- **Automatic Subscription**: SQS queue is automatically subscribed to SNS topic
- **Dead Letter Queue**: Failed messages automatically move to DLQ after max receive count
- **Encryption**: Optional KMS encryption for messages
- **FIFO Support**: Optional FIFO queues/topics for ordered, exactly-once delivery
- **Content-Based Deduplication**: Automatic deduplication for FIFO topics/queues

## Notes

- FIFO topics and queues require `.fifo` suffix (automatically added)
- Dead letter queue is automatically created with naming pattern: `{name}-dlq`
- SQS queue is automatically subscribed to SNS topic
- IAM policy provides permissions for both publishing and consuming
- Visibility timeout should be at least as long as message processing time

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

| Name | Source | Version |
|------|--------|---------|
| <a name="module_sns_topic"></a> [sns\_topic](#module\_sns\_topic) | ../../foundation/sns-topic | n/a |
| <a name="module_sqs_queue"></a> [sqs\_queue](#module\_sqs\_queue) | ../../foundation/sqs-queue | n/a |
| <a name="module_sqs_subscription_policy"></a> [sqs\_subscription\_policy](#module\_sqs\_subscription\_policy) | ../../foundation/iam-policy | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_sns_topic_subscription.sqs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription) | resource |
| [aws_sqs_queue_policy.sns_subscription](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_fifo_enabled"></a> [fifo\_enabled](#input\_fifo\_enabled) | Whether to use FIFO (first-in-first-out) queues and topics. | `bool` | `false` | no |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | KMS key ID for encrypting messages. If not provided, AWS managed encryption is used. | `string` | `null` | no |
| <a name="input_max_receive_count"></a> [max\_receive\_count](#input\_max\_receive\_count) | Maximum number of receives before moving message to DLQ. | `number` | `3` | no |
| <a name="input_name"></a> [name](#input\_name) | Base name used for resources created by this pattern. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Base tags applied to all resources. | `map(string)` | `{}` | no |
| <a name="input_visibility_timeout_seconds"></a> [visibility\_timeout\_seconds](#input\_visibility\_timeout\_seconds) | Visibility timeout for SQS messages in seconds. | `number` | `30` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dlq_arn"></a> [dlq\_arn](#output\_dlq\_arn) | ARN of the dead letter queue. |
| <a name="output_dlq_url"></a> [dlq\_url](#output\_dlq\_url) | URL of the dead letter queue. |
| <a name="output_sns_topic_arn"></a> [sns\_topic\_arn](#output\_sns\_topic\_arn) | ARN of the SNS topic. |
| <a name="output_sns_topic_name"></a> [sns\_topic\_name](#output\_sns\_topic\_name) | Name of the SNS topic. |
| <a name="output_sqs_queue_arn"></a> [sqs\_queue\_arn](#output\_sqs\_queue\_arn) | ARN of the SQS queue. |
| <a name="output_sqs_queue_name"></a> [sqs\_queue\_name](#output\_sqs\_queue\_name) | Name of the SQS queue. |
| <a name="output_sqs_queue_url"></a> [sqs\_queue\_url](#output\_sqs\_queue\_url) | URL of the SQS queue. |
| <a name="output_subscription_policy_arn"></a> [subscription\_policy\_arn](#output\_subscription\_policy\_arn) | ARN of the IAM policy for SQS subscription. |
<!-- END_TF_DOCS -->
