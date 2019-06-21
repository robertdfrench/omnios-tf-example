resource "aws_instance" "omnios" {
	ami = local.ami
	key_name = data.external.hostname.result.stdout
	instance_type = "t2.micro"
	security_groups = [aws_security_group.allow_ssh.name]
}
