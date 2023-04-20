locals {
  vpc_id = var.vpc_id
  cidr_block = var.cidr_block
  internet_gateway_id = var.internet_gateway_id
}

resource aws_subnet "default" {
  vpc_id = local.vpc_id
  cidr_block = local.cidr_block
  availability_zone = var.availability_zone
  tags = {
    Name = "${var.base_name}-Public"
  }
}

resource aws_route_table "public" {
  vpc_id = local.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = local.internet_gateway_id
  }
  tags = {
    Name = var.base_name
  }
}

resource aws_route_table_association "public" {
  subnet_id = aws_subnet.default.id
  route_table_id = aws_route_table.public.id
}