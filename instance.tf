resource aws_instance "instance_a" {
  ami = "ami-0f960c8194f5d8df5"
  instance_type = "t3.micro"
  subnet_id = module.public_subnet_a.subnet_id
  vpc_security_group_ids = [aws_security_group.instances.id]
  tags = {
    Name = "instance_a"
  }
  associate_public_ip_address = true
  user_data_base64 = "IyEvYmluL2Jhc2gKeXVtIHVwZGF0ZSAteQp5dW0gaW5zdGFsbCAteSBodHRwZApzeXN0ZW1jdGwgc3RhcnQgaHR0cGQKc3lzdGVtY3RsIGVtYWJsZSBodHRwZAplY2hvICI8aDE+SGVsbG8gZnJvbSAkKGhvc3RuYW1lIC1mKTwvaDE+IiA+IC92YXIvd3d3L2h0bWwvaW5kZXguaHRtbAo="
}

resource aws_instance "instance_b" {
  ami = "ami-0f960c8194f5d8df5"
  instance_type = "t3.micro"
  subnet_id = module.public_subnet_a.subnet_id
  vpc_security_group_ids = [aws_security_group.instances.id]
  tags = {
    Name = "instance_b"
  }
  associate_public_ip_address = true
  user_data_base64 = "IyEvYmluL2Jhc2gKeXVtIHVwZGF0ZSAteQp5dW0gaW5zdGFsbCAteSBodHRwZApzeXN0ZW1jdGwgc3RhcnQgaHR0cGQKc3lzdGVtY3RsIGVtYWJsZSBodHRwZAplY2hvICI8aDE+SGVsbG8gZnJvbSAkKGhvc3RuYW1lIC1mKTwvaDE+IiA+IC92YXIvd3d3L2h0bWwvaW5kZXguaHRtbAo="
}

resource aws_security_group "instances" {
  name = "DemoSG"
  description = "Allow inbound traffic from the internet"
  vpc_id = aws_vpc.default.id

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}