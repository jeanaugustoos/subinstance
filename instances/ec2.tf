resource "aws_instance" "ec2" {
  ami             = "${var.ami}"
  instance_type   = "${var.instance_type}"
  key_name        = "${var.key_name}"
  security_groups = ["${var.security_group_name}"]
}
