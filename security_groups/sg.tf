resource "aws_security_group" "sg" {
  name        = "${var.sg_name}"
  description = "Allow inbound SSH and outbound all"

  ingress {
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

  tags {
    Name = "SG-Inbound-SSH-Outbound-All"
  }
}
