resource aws_vpc "default" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "2im-Demo"
  }
}

resource aws_subnet "public" {
  vpc_id = aws_vpc.default.id
  cidr_block = "10.0.10.0/24"
  tags = {
    Name = "2im-Demo-Public"
  }
}