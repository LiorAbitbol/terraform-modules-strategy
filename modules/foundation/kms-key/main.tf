resource "aws_kms_key" "this" {
  description              = var.description
  deletion_window_in_days  = var.deletion_window_in_days
  enable_key_rotation      = var.enable_key_rotation
  key_usage                = var.key_usage
  customer_master_key_spec = var.customer_master_key_spec
  multi_region             = var.multi_region
  policy                   = var.policy

  tags = merge(
    {
      Name = var.name
    },
    var.tags
  )
}

locals {
  alaises_by_index = {
    for i, a in var.aliases : tostring(i) => a
  }
}

resource "aws_kms_alias" "this" {
  #for_each = toset(var.aliases)
  for_each = local.alaises_by_index

  name          = "alias/${each.value}"
  target_key_id = aws_kms_key.this.key_id
}
