

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

  ingress {
    description = "Allow https"
    from_port   = 443
    to_port     = 443
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
    Name = "firco_sec"
  }

}

resource "aws_security_group" "firco_efs_sec" {
  name        = var.efs_firco_sg
  description = "security group for firco efs"
  vpc_id      = data.aws_vpc.firco_vpc.id

  ingress {
    description = "Allow NFS"
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = [var.subnet_ids]
  }

  egress {
    description = "Egress traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "firco_efs_sec"
  }

}