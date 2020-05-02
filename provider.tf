terraform {
  required_version = ">= 0.12.24"
}

variable "region" {
  default = "eu-central-1"
}

provider "aws" {
  region = var.region
}
