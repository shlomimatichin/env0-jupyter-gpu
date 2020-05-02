data "aws_ami" "prebuilt" {
  most_recent = true

  filter {
    name   = "name"
    values = ["Deep Learning AMI (Ubuntu 18.04) Version 28.0"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"]
}
