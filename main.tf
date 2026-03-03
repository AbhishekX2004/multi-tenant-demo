terraform {
  backend "s3" {}
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

variable "instance_count" {
  type    = number
  default = 1
}

resource "aws_instance" "node" {
  count         = var.instance_count
  ami           = "ami-0c7217cdde317cfec"
  instance_type = "t2.micro"

  root_block_device {
    volume_size = 8
    volume_type = "gp2"
  }

  tags = {
    Name = "node-${count.index}"
  }
}