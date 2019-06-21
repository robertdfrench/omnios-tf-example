data "external" "pubkey_path" {
  program = ["bash", "get_pubkey_path.sh"]
}

data "local_file" "ssh_pubkey" {
  filename = data.external.pubkey_path.result.pubkey
}

resource "aws_key_pair" "ssh_key" {
  key_name   = "omnios"
  public_key = data.local_file.ssh_pubkey.content
}
