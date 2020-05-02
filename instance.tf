variable "instance_type" {
  default = "p2.xlarge"
}

resource "aws_instance" "workstation" {
  ami                    = data.aws_ami.prebuilt.id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.ephemeral_ssh_key.key_name
  vpc_security_group_ids = [aws_security_group.ssh_access.id]

  tags = {
    Name = "Jupyter Notebook Workstation"
  }
}

output "workstation_dns" {
  value = aws_instance.workstation.public_dns
}

resource "random_string" "sg-uid" {
  length = 8
  special = false
}

resource "aws_default_vpc" "default" {}

resource "aws_security_group" "ssh_access" {
  name        = "Workstation SSH Access ${random_string.sg-uid.result}"
  description = "SSH access to Jupyter Notebook Workstation"
  vpc_id      = aws_default_vpc.default.id

  ingress {
    description = "SSH from anywhere"
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
}
