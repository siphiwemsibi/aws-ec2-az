

resource "aws_security_group" "firco_sec" {
  name        = var.sec_group
  description = "security group for firco"
  vpc_id      = data.aws_vpc.firco_vpc.id

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Egress traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    "Name" = "firco_sec"
  }

}