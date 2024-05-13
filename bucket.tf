
provider "aws" {
    region = "global"
}
  resource "aws_s3_bucket" "my bucket" {
  bucket = "my-tf-test-bucket"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}