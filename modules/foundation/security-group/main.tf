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
        cidr_blocks      = null
        ipv6_cidr_blocks = null
        prefix_list_ids  = null
        security_groups  = null
        self             = null
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

  source_security_group_id = length(each.value.security_groups) > 0 ? each.value.security_groups[0] : null

  self = (
    length(each.value.security_groups) > 0 ? null :
    each.value.self == true ? true : null
  )

  cidr_blocks = (
    (length(each.value.security_groups) > 0 || each.value.self == true) ? null :
    (each.value.cidr_blocks != null && length(each.value.cidr_blocks) > 0) ? each.value.cidr_blocks : null
  )

  ipv6_cidr_blocks = (
    (length(each.value.security_groups) > 0 || each.value.self == true) ? null :
    (each.value.ipv6_cidr_blocks != null && length(each.value.ipv6_cidr_blocks) > 0) ? each.value.ipv6_cidr_blocks : null
  )

  prefix_list_ids = (
    (length(each.value.security_groups) > 0 || each.value.self == true) ? null :
    (each.value.prefix_list_ids != null && length(each.value.prefix_list_ids) > 0) ? each.value.prefix_list_ids : null
  )

  description = each.value.description
}

resource "aws_security_group_rule" "egress" {
  for_each = local.egress_rules

  type              = "egress"
  security_group_id = aws_security_group.this.id

  protocol  = each.value.protocol
  from_port = each.value.from_port
  to_port   = each.value.to_port

  source_security_group_id = length(each.value.security_groups) > 0 ? each.value.security_groups[0] : null

  self = (
    length(each.value.security_groups) > 0 ? null :
    each.value.self == true ? true : null
  )

  cidr_blocks = (
    (length(each.value.security_groups) > 0 || each.value.self == true) ? null :
    (each.value.cidr_blocks != null && length(each.value.cidr_blocks) > 0) ? each.value.cidr_blocks : null
  )

  ipv6_cidr_blocks = (
    (length(each.value.security_groups) > 0 || each.value.self == true) ? null :
    (each.value.ipv6_cidr_blocks != null && length(each.value.ipv6_cidr_blocks) > 0) ? each.value.ipv6_cidr_blocks : null
  )

  prefix_list_ids = (
    (length(each.value.security_groups) > 0 || each.value.self == true) ? null :
    (each.value.prefix_list_ids != null && length(each.value.prefix_list_ids) > 0) ? each.value.prefix_list_ids : null
  )

  description = each.value.description
}
