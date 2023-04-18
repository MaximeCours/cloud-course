resource aws_instance "default" {
    ami = "ami-0f960c8194f5d8df5"
    instance_type = "t3.micro"
    tags = {
        Name = "Demo-2im"
    }
    subnet_id = aws_subnet.public.id
    vpc_security_group_ids = [
      aws_security_group.public_instances.id
    ]
    associate_public_ip_address = true
}

resource aws_security_group "public_instances" {
  vpc_id = aws_vpc.default.id
  name = "public-instances"
  ingress {
    from_port = 22
    protocol  = "tcp"
    to_port   = 22
    cidr_blocks = ["0.0.0.0/0"]
    description = "allows ssh from anywhere"
  }

  ingress {
    protocol = "icmp"
    from_port = -1
    to_port = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}
