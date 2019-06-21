provider "external" {}

data "external" "ip_address" {
  program = ["bash", "get_ip.sh"]
}

locals {
  ip = data.external.ip_address.result.ip
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = [join("/", [local.ip, "32"])]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
