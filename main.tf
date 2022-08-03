locals {
  deploy_vpc = true
  vpc_id     = local.deploy_vpc ? aws_vpc.this.0.id : var.vpc_id
}

resource "aws_vpc" "this" {
  count      = local.deploy_vpc ? 1 : 0
  cidr_block = var.vpc_cidr
}

resource "aws_vpc_ipv4_cidr_block_association" "this" {
  count      = local.deploy_vpc ? length(var.secondary_vpc_cidrs) : 0
  vpc_id     = local.vpc_id
  cidr_block = element(var.secondary_vpc_cidrs, count.index)
}

resource "aws_subnet" "this" {
  for_each          = { for subnet in var.private_subnets : subnet.cidr => subnet }
  vpc_id            = local.vpc_id
  cidr_block        = each.value.cidr
  availability_zone = element(var.availability_zones, each.value.availability_zone_index)
  tags = {
    Name = "merge tags with name"
  }
  depends_on = [
    aws_vpc.this,
    aws_vpc_ipv4_cidr_block_association.this
  ]
}