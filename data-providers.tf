
#Data lookup for the latest Red Hat8 image
data "aws_ami" "rhel8_latest" {
  most_recent = true

  filter {
    name   = "name"
    values = ["RHEL_HA-8*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]

  }

  owners = ["309956199498"]
}

#Data lookup for the vpc/subnets
data "aws_vpc" "firco_vpc" {
  id = var.vpc_id
}

data "aws_subnet" "subnet1" {
  id = var.subnet_ids[0]
}

data "aws_subnet" "subnet2" {
  id = var.subnet_ids[1]
}