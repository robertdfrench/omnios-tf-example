data "external" "pubkey" {
  program = ["bash", "-c", "cat $HOME/.ssh/id_rsa.pub | jq -R '{stdout: .}'"]
}

data "external" "hostname" {
  program = ["bash", "-c", "hostname | jq -R '{stdout: .}'"]
}

resource "aws_key_pair" "ssh_key" {
  key_name   = data.external.hostname.result.stdout
  public_key = data.external.pubkey.result.stdout
}
