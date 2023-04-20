module "public_subnet_a"  {
  source = "./modules/public_subnet"

  cidr_block = "10.0.21.0/24"
  vpc_id = aws_vpc.default.id
  availability_zone = "${var.AWS_REGION}a"
  internet_gateway_id = aws_internet_gateway.default.id

}

module "public_subnet_b"  {
  source = "./modules/public_subnet"

  cidr_block = "10.0.22.0/24"
  vpc_id = aws_vpc.default.id
  availability_zone = "${var.AWS_REGION}b"
  internet_gateway_id = aws_internet_gateway.default.id
}




resource aws_alb_target_group "default" {
  name = var.BASE_NAME
  port = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.default.id
  target_type = "instance"
}

resource aws_alb_target_group_attachment "instance_a" {
  target_group_arn = aws_alb_target_group.default.arn
    target_id = aws_instance.instance_a.id
  port = 80
}

resource aws_alb_target_group_attachment "instance_b" {
  target_group_arn = aws_alb_target_group.default.arn
  target_id = aws_instance.instance_b.id
  port = 80
}

resource aws_alb "default" {
  name = var.BASE_NAME
  subnets = [module.public_subnet_a.subnet_id, module.public_subnet_b.subnet_id]
  security_groups = [aws_security_group.alb_sg.id]
  internal = false
  load_balancer_type = "application"
  enable_deletion_protection = false

}

resource aws_security_group "alb_sg" {
  name = var.BASE_NAME
  description = "Allow inbound traffic from the internet"
  vpc_id = aws_vpc.default.id

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
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

resource "aws_alb_listener" "lb_listener_https_test" {
  load_balancer_arn = aws_alb.default.id
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.default.id
  }
}