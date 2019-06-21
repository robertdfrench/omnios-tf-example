data "external" "ip_address" {
  program = ["bash", "-c", "curl -4 -q ifconfig.co/json | jq -r '{ip4: .ip}'"]
}

locals {
  ip4_cidr = join("/", [data.external.ip_address.result.ip4, "32"])
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = [local.ip4_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
