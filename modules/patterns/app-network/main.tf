locals {
  base_tags = merge(
    {
      Pattern = "app-network"
      Name    = var.name
    },
    var.tags
  )

  # Build ingress rules from ports + allowed CIDRs
  ingress_rules = flatten([
    for p in var.app_ingress_ports : [
      {
        type        = "ingress"
        protocol    = "tcp"
        from_port   = p
        to_port     = p
        cidr_blocks = var.allowed_ingress_cidr_blocks
        description = "App ingress tcp/${p}"
      }
    ]
  ])

  # Always allow all egress (common pattern)
  egress_rules = [
    {
      type        = "egress"
      protocol    = "-1"
      from_port   = 0
      to_port     = 0
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow all outbound"
    }
  ]
}

module "vpc" {
  source = "../../foundation/vpc"

  name                 = var.name
  cidr_block           = var.vpc_cidr_block
  azs                  = var.azs
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs

  tags = local.base_tags
}

module "app_security_group" {
  source = "../../foundation/security-group"

  name        = "${var.name}-app"
  description = "Default application security group for ${var.name}"
  vpc_id      = module.vpc.vpc_id

  rules = concat(local.ingress_rules, local.egress_rules)

  tags = local.base_tags
}
