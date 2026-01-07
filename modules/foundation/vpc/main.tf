resource "aws_vpc" "this" {
  cidr_block           = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(
    {
      Name = var.name
    },
    var.tags
  )
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = merge(
    {
      Name = "${var.name}-igw"
    },
    var.tags
  )
}

resource "aws_subnet" "public" {
  for_each = {
    for idx, az in var.azs :
    az => {
      cidr = var.public_subnet_cidrs[idx]
    }
  }

  vpc_id                  = aws_vpc.this.id
  cidr_block              = each.value.cidr
  availability_zone       = each.key
  map_public_ip_on_launch = true

  tags = merge(
    {
      Name = "${var.name}-public-${each.key}"
    },
    var.tags
  )
}

resource "aws_subnet" "private" {
  for_each = {
    for idx, az in var.azs :
    az => {
      cidr = var.private_subnet_cidrs[idx]
    }
  }

  vpc_id            = aws_vpc.this.id
  cidr_block        = each.value.cidr
  availability_zone = each.key

  tags = merge(
    {
      Name = "${var.name}-private-${each.key}"
    },
    var.tags
  )
}