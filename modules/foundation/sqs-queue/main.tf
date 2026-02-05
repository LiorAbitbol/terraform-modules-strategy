resource "aws_sqs_queue" "dlq" {
  count = var.dead_letter_queue_name != null ? 1 : 0

  name                        = var.dead_letter_queue_name
  message_retention_seconds   = var.message_retention_seconds
  fifo_queue                  = var.fifo_queue
  content_based_deduplication = var.content_based_deduplication

  tags = merge(
    {
      Name = var.dead_letter_queue_name
    },
    var.tags
  )
}

resource "aws_sqs_queue" "this" {
  name                        = var.name
  visibility_timeout_seconds  = var.visibility_timeout_seconds
  message_retention_seconds   = var.message_retention_seconds
  delay_seconds               = var.delay_seconds
  receive_wait_time_seconds   = var.receive_wait_time_seconds
  fifo_queue                  = var.fifo_queue
  content_based_deduplication = var.content_based_deduplication

  kms_master_key_id                 = var.kms_key_id
  kms_data_key_reuse_period_seconds = var.kms_data_key_reuse_period_seconds

  redrive_policy = var.dead_letter_queue_name != null ? jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dlq[0].arn
    maxReceiveCount     = var.max_receive_count
  }) : null

  tags = merge(
    {
      Name = var.name
    },
    var.tags
  )
}
