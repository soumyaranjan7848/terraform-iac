terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.10.0"
    }
  }
}

provider "aws" {
  region = var.region
}

resource "aws_instance" "myserver" {
  ami = "ami-0705384c0b33c194c"
  instance_type = "t3.micro"

  tags = {
    Name="SampleServer"
  }
}