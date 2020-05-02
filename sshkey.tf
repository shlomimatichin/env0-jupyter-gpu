resource "tls_private_key" "ephemeral_ssh_key" {
  algorithm = "RSA"
}

resource "aws_key_pair" "ephemeral_ssh_key" {
  key_name_prefix = "Jupiter Workstation Throw-away key"
  public_key      = tls_private_key.ephemeral_ssh_key.public_key_openssh
}

output "ephemeral_ssh_key_private_pem" {
  value = tls_private_key.ephemeral_ssh_key.private_key_pem
  sensitive = true
}
