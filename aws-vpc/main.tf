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

# Creating VPC

resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name= "My_vpc"
  }
}

# Creating Public-Subnet
resource "aws_subnet" "public_subnet" {
    cidr_block = "0.0.1.0/24"
    vpc_id = aws_vpc.my_vpc.id
    tags = {
      Name="public_subnet"
    }
}

# Creating Private-Subnet
resource "aws_subnet" "private_subnet" {
    cidr_block = "0.0.2.0/24"
    vpc_id = aws_vpc.my_vpc.id
    tags = {
      Name="private_subnet"
    }
}

# Creating Internet Getway
resource "aws_internet_gateway" "my-igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name= "my-igw"
  }
}

# Creating Route Table
resource "aws_route_table" "my_rt" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block= "0.0.0.0/0"
    gateway_id= aws_internet_gateway.my-igw.id
  }
}

resource "aws_route_table_association" "public-sub" {
    route_table_id = aws_route_table.my_rt.id
    subnet_id      = aws_subnet.public_subnet.id
}

# Creating Ec2 Instance
resource "aws_instance" "myserver" {
  ami = "ami-0705384c0b33c194c"
  instance_type = "t3.micro"
  subnet_id = aws_subnet.private_subnet.id

  tags = {
    Name="SampleServer"
  }
}