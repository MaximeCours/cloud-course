variable "vpc_id" {
  type = string
}

variable "cidr_block" {
  type = string
}

variable "availability_zone" {
  type = string
}

variable base_name {
  type = string
  default = "2im-Demo"
}

variable "internet_gateway_id" {
  type = string
}
