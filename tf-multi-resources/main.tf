terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.10.0"
    }
  }
}

provider "aws" {
  region = "eu-north-1"
} 

locals {
  project= "project-01"
}

resource "aws_vpc" "my-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name= "${local.project}-vpc"
  }
}

resource "aws_subnet" "main" {
  vpc_id = aws_vpc.my-vpc.id
  cidr_block = "10.0.${count.index}.0/24"
  count = 2
  tags = {
    Name= "${local.project}-subnet-${count.index}"
  }
}

# Creating 4 EC2 instance
resource "aws_instance" "main" {
  ami           = "ami-0705384c0b33c194c"
  instance_type = "t2.micro"
  count         = 4
  subnet_id     = element(aws_subnet.main[*].id, count.index % length(aws_subnet.main))


  tags = {
    Name= "${local.project}-instance-${count.index}"
  }

}

output "aws_subnet_id" {
  value = aws_subnet.main[0].id
}