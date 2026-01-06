resource "aws_security_group" "this" {
  name        = var.name
  description = var.description
  vpc_id      = var.vpc_id

  tags = merge(
    {
      Name = var.name
    },
    var.tags
  )
}

locals {
  rules = [
    for r in var.rules : merge(
      {
        cidr_blocks      = []
        ipv6_cidr_blocks = []
        prefix_list_ids  = []
        security_groups  = []
        self             = false
        description      = null
      },
      r
    )
  ]

  ingress_rules = {
    for idx, r in local.rules :
    idx => r if r.type == "ingress"
  }

  egress_rules = {
    for idx, r in local.rules :
    idx => r if r.type == "egress"
  }
}

resource "aws_security_group_rule" "ingress" {
  for_each = local.ingress_rules

  type              = "ingress"
  security_group_id = aws_security_group.this.id

  protocol  = each.value.protocol
  from_port = each.value.from_port
  to_port   = each.value.to_port

  cidr_blocks              = each.value.cidr_blocks
  ipv6_cidr_blocks         = each.value.ipv6_cidr_blocks
  prefix_list_ids          = each.value.prefix_list_ids
  source_security_group_id = length(each.value.security_groups) > 0 ? each.value.security_groups[0] : null
  self                     = each.value.self
  description              = each.value.description
}

resource "aws_security_group_rule" "egress" {
  for_each = local.egress_rules

  type              = "egress"
  security_group_id = aws_security_group.this.id

  protocol  = each.value.protocol
  from_port = each.value.from_port
  to_port   = each.value.to_port

  cidr_blocks              = each.value.cidr_blocks
  ipv6_cidr_blocks         = each.value.ipv6_cidr_blocks
  prefix_list_ids          = each.value.prefix_list_ids
  source_security_group_id = length(each.value.security_groups) > 0 ? each.value.security_groups[0] : null
  self                     = each.value.self
  description              = each.value.description
}
