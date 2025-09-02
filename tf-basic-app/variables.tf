variable "aws_region" {
  description = "AWS region to deploy resources"
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project name prefix"
  default     = "tf-basic-app"
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}
