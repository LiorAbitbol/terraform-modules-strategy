provider "aws" {
  region = var.aws_region
}

module "app_network" {
  source = "../../modules/patterns/app-network"

  name           = var.name
  vpc_cidr_block = var.vpc_cidr_block

  azs                  = var.azs
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs

  allowed_ingress_cidr_blocks = var.allowed_ingress_cidr_blocks
  app_ingress_ports           = var.app_ingress_ports

  tags = var.tags
}
