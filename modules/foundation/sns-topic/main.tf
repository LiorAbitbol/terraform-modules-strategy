resource "aws_sns_topic" "this" {
  name                        = var.name
  display_name                = var.display_name
  kms_master_key_id           = var.kms_key_id
  fifo_topic                  = var.fifo_topic
  content_based_deduplication = var.content_based_deduplication

  tags = merge(
    {
      Name = var.name
    },
    var.tags
  )
}
