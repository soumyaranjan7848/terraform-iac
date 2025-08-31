terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.10.0"
    }
  }
}

provider "aws" {
  region = "eu-north-1"
}

locals {
  owner ="ABC"
  name="MySERVER"
}

resource "aws_instance" "myserver" {
  ami           = "ami-0705384c0b33c194c"
  instance_type = var.aws_instance_type

  root_block_device {
    delete_on_termination = true
    volume_size           = var.ec2_config.v_size
    volume_type           = var.ec2_config.v_type
  }

  tags = merge(var.additional_tags, {
    Name = local.name
  })
}