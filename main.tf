

terraform {
  backend "s3" {
    bucket  = "firco-tfstate-bucket"
    key     = "fircotf"
    region  = "af-south-1"
    encrypt = true
  }
}

resource "aws_ebs_volume" "ebs_vol" {
  count             = "2"
  availability_zone = element(aws_instance.firco_ec2.*.availability_zone, count.index)
  size              = 250

  tags = {
    "Name" = "firco-ebs ${count.index}"
  }
}

resource "aws_volume_attachment" "ebsvol_attach" {
  count       = 2
  device_name = "/dev/sdb"
  volume_id   = aws_ebs_volume.ebs_vol.*.id[count.index]
  instance_id = element(aws_instance.firco_ec2.*.id, count.index)
}

resource "aws_instance" "firco_ec2" {
  ami                    = data.aws_ami.rhel8_latest.id
  instance_type          = var.instance_type
  count                  = "2"
  vpc_security_group_ids = [aws_security_group.firco_sec.id]
  subnet_id              = element(var.subnet_ids, count.index)
  key_name               = var.key_name

  tags = {
    Name = "firco-server ${count.index}"
  }

}
