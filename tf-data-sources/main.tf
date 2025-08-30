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

# aws ami
data "aws_ami" "name" {
    most_recent = true
    owners = [ "amazon" ]
}
output "aws_ami" {
  value = data.aws_ami.name.id
}

# Security group
data "aws_security_group" "name" {
    tags = {
      mywebserver = "http"
      }
    }  
output "aws_sg" {
  value = data.aws_security_group.name.id
}

# Creating VPC
data "aws_vpc" "name" {
  tags = {
    ENV="PROD"
    Name="my-vpc"
  }
}
output "aws_id" {
  value = data.aws_vpc.name.id
}

# Creating Subnet
data "aws_subnet" "name" {
  filter {
    name="vpc-id"
    values = [ data.aws_vpc.name.id ]
  }
  tags = {
    Name = "private-subnet"
  }
}

# Creat Availavility_zone
data "aws_availability_zones" "name" {
  state = "available"
}
output "aws_zone" {
  value = data.aws_availability_zones.names
}

# To get the Account details
data "aws_caller_identity" "name" {
}
output "caller_info" {
  value = data.aws_caller_identity.name
}

# Creating Region
data "aws_region" "name" {
}
output "region_name" {
  value = data.aws_region.name
}


resource "aws_instance" "myserver" {
  ami           = "ami-0705384c0b33c194c"
  instance_type = "t3.micro"
  subnet_id = data.aws_subnet.name.id
  security_groups = [ data.aws_security_group.name.id ]

  tags = {
    Name = "SampleServer"
  }
}