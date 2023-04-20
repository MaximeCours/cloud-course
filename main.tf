module "instance_set_a"  {
  source = "./modules/instance_set"

  cidr_block = "10.0.21.0/24"
  vpc_id = aws_vpc.default.id
  availability_zone = "${var.AWS_REGION}a"
  internet_gateway_id = aws_internet_gateway.default.id

}

module "instance_set_b"  {
  source = "./modules/instance_set"

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

resource aws_alb_target_group_attachment "set_a" {
  target_group_arn = aws_alb_target_group.default.arn
  target_id = module.instance_set_a.instance_id
  port = 80
}

resource aws_alb_target_group_attachment "set_b" {
  target_group_arn = aws_alb_target_group.default.arn
  target_id = module.instance_set_b.instance_id
  port = 80
}

