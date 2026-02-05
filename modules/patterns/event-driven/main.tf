locals {
  base_tags = merge(
    {
      Pattern = "event-driven"
      Name    = var.name
    },
    var.tags
  )

  resource_suffix = var.fifo_enabled ? ".fifo" : ""
}

module "sns_topic" {
  source = "../../foundation/sns-topic"

  name                        = "${var.name}${local.resource_suffix}"
  fifo_topic                  = var.fifo_enabled
  content_based_deduplication = var.fifo_enabled
  kms_key_id                  = var.kms_key_id

  tags = local.base_tags
}

module "sqs_queue" {
  source = "../../foundation/sqs-queue"

  name                        = "${var.name}${local.resource_suffix}"
  fifo_queue                  = var.fifo_enabled
  content_based_deduplication = var.fifo_enabled
  visibility_timeout_seconds  = var.visibility_timeout_seconds
  max_receive_count           = var.max_receive_count
  dead_letter_queue_name      = "${var.name}-dlq${local.resource_suffix}"
  kms_key_id                  = var.kms_key_id

  tags = local.base_tags
}

module "sqs_subscription_policy" {
  source = "../../foundation/iam-policy"

  name        = "${var.name}-sqs-subscribe"
  description = "Policy for subscribing SQS queue to SNS topic"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "sqs:SendMessage",
          "sqs:ReceiveMessage",
          "sqs:DeleteMessage",
          "sqs:GetQueueAttributes"
        ]
        Resource = module.sqs_queue.queue_arn
      },
      {
        Effect = "Allow"
        Action = [
          "sns:Subscribe",
          "sns:Receive"
        ]
        Resource = module.sns_topic.topic_arn
      }
    ]
  })

  tags = local.base_tags
}

resource "aws_sqs_queue_policy" "sns_subscription" {
  queue_url = module.sqs_queue.queue_url

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "sns.amazonaws.com"
        }
        Action   = "sqs:SendMessage"
        Resource = module.sqs_queue.queue_arn
        Condition = {
          ArnEquals = {
            "aws:SourceArn" = module.sns_topic.topic_arn
          }
        }
      }
    ]
  })
}

resource "aws_sns_topic_subscription" "sqs" {
  topic_arn = module.sns_topic.topic_arn
  protocol  = "sqs"
  endpoint  = module.sqs_queue.queue_arn
}
