provider "aws" {
    region = "ap-south-1"
  
}
resource "aws_instance" "ubuntu_servre" {
    ami = "ami-078264b8ba71bc45e"
    key_name = "krish.pem"
    count = 1
    instance_type = "t2.micro"
  
}
output "created_server" {
    value = "yes"
  
}