resource aws_vpc "default" {
    cidr_block = var.VPC_CIDR
}

resource aws_internet_gateway "default" {
    vpc_id = aws_vpc.default.id
}