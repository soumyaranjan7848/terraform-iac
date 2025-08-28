terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.10.0"
    }
    random = {
        source = "hashicorp/random"
        version = "3.6.2"
    }
  }
}

provider "aws" {
  region = "eu-north-1"
}

resource "random_id" "rand-id" {
  byte_length = 8
}

resource "aws_s3_bucket" "demo-bucket" {
  bucket = "demo-s3-bucket-${random_id.rand-id.hex}"

}
resource "asw_s3_object" "bucket-data" {
    bucket= aws_s3_bucket.demo-bucket.bucket
    source= "./myfile.txt"
    key   = "mydata.txt "
}

output "name" {
  value = random_id.rand-id.hex
}