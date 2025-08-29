terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.10.0"
    }
  }
  backend "s3" {
    bucket = "demo-bucket-9419a72476f569ef"
    key = "backend.tfstate"
    region = "eu-north-1"
  }
}

provider "aws" {
  region = "er-north-1"
}

resource "aws_instance" "myserver" {
  ami = "ami-0705384c0b33c194c"
  instance_type = "t3.micro"

  tags = {
    Name="SampleServer"
  }
}