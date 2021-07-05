resource "aws_efs_file_system" "my_efs" {
  creation_token = "firco-efs1"

  tags = {
    "Name" = "firco-efs1"
  }
}

resource "aws_efs_mount_target" "my_efs_mount" {
  file_system_id  = aws_efs_file_system.my_efs.id
  subnet_id       = var.subnet_ids
  security_groups = ["${aws_security_group.firco_efs_sec}"]

}

resource "aws_efs_access_point" "my_efs_access" {
  file_system_id = aws_efs_file_system.my_efs.id
  id             = "firco-access"
}