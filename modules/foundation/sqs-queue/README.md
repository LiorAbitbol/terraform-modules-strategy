# SQS Queue (Foundation)

Creates an AWS SQS (Simple Queue Service) queue for message queuing with optional dead letter queue.

This is a **foundation module**: it provides a reusable SQS queue primitive. Queue policies
and subscriptions should be handled separately or in **pattern modules**.

## Usage

```hcl
module "processing_queue" {
  source = "../../modules/foundation/sqs-queue"

  name                      = "order-processing"
  visibility_timeout_seconds = 60
  message_retention_seconds  = 604800

  max_receive_count        = 3
  dead_letter_queue_name   = "order-processing-dlq"

  kms_key_id = "arn:aws:kms:us-east-1:123456789012:key/12345678-1234-1234-1234-123456789012"

  tags = {
    Environment = "prod"
    Owner       = "platform"
  }
}

# FIFO queue example
module "order_events_fifo" {
  source = "../../modules/foundation/sqs-queue"

  name                        = "order-events.fifo"
  fifo_queue                  = true
  content_based_deduplication = true

  max_receive_count      = 5
  dead_letter_queue_name = "order-events-dlq.fifo"

  tags = {
    Environment = "prod"
    Owner       = "platform"
  }
}
```

## Notes

- FIFO queues require `.fifo` suffix in the name.
- Dead letter queues are automatically created if `dead_letter_queue_name` is provided.
- Visibility timeout should be at least as long as message processing time.
- KMS encryption is recommended for sensitive messages.
- Content-based deduplication helps prevent duplicate messages in FIFO queues.
- Long polling (`receive_wait_time_seconds`) reduces API calls and improves efficiency.

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
| [aws_sqs_queue.dlq](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue) | resource |
| [aws_sqs_queue.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_content_based_deduplication"></a> [content\_based\_deduplication](#input\_content\_based\_deduplication) | Enable content-based deduplication for FIFO queues. | `bool` | `false` | no |
| <a name="input_dead_letter_queue_name"></a> [dead\_letter\_queue\_name](#input\_dead\_letter\_queue\_name) | Name for the dead letter queue. If not provided, DLQ will not be created. | `string` | `null` | no |
| <a name="input_delay_seconds"></a> [delay\_seconds](#input\_delay\_seconds) | Delay in seconds before messages become available (0-900). | `number` | `0` | no |
| <a name="input_fifo_queue"></a> [fifo\_queue](#input\_fifo\_queue) | Whether this is a FIFO queue (first-in-first-out delivery). | `bool` | `false` | no |
| <a name="input_kms_data_key_reuse_period_seconds"></a> [kms\_data\_key\_reuse\_period\_seconds](#input\_kms\_data\_key\_reuse\_period\_seconds) | Time in seconds for KMS data key reuse (60-86400). | `number` | `300` | no |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | ARN of the KMS key for encrypting messages. If not provided, SQS managed encryption is used. | `string` | `null` | no |
| <a name="input_max_receive_count"></a> [max\_receive\_count](#input\_max\_receive\_count) | Maximum number of receives before moving to DLQ. Set to 0 to disable DLQ. | `number` | `3` | no |
| <a name="input_message_retention_seconds"></a> [message\_retention\_seconds](#input\_message\_retention\_seconds) | Number of seconds to retain messages (60-1209600). | `number` | `345600` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the SQS queue. | `string` | n/a | yes |
| <a name="input_receive_wait_time_seconds"></a> [receive\_wait\_time\_seconds](#input\_receive\_wait\_time\_seconds) | Long polling wait time in seconds (0-20). | `number` | `0` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags to apply to all resources. | `map(string)` | `{}` | no |
| <a name="input_visibility_timeout_seconds"></a> [visibility\_timeout\_seconds](#input\_visibility\_timeout\_seconds) | Visibility timeout for messages in seconds (0-43200). | `number` | `30` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dlq_arn"></a> [dlq\_arn](#output\_dlq\_arn) | ARN of the dead letter queue (if created). |
| <a name="output_dlq_url"></a> [dlq\_url](#output\_dlq\_url) | URL of the dead letter queue (if created). |
| <a name="output_queue_arn"></a> [queue\_arn](#output\_queue\_arn) | ARN of the SQS queue. |
| <a name="output_queue_name"></a> [queue\_name](#output\_queue\_name) | Name of the SQS queue. |
| <a name="output_queue_url"></a> [queue\_url](#output\_queue\_url) | URL of the SQS queue. |
<!-- END_TF_DOCS -->
