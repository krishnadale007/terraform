# terraform {
#     required_providers {
#       aws  = {
#         source = "hashicorp/aws"
#         version = "5.40.0"
#       }
#     }
# }
# provider "aws" {
#     region = "ap-south-1"
#     #shared_config_files = ["/home/ubuntu/.aws/config"]
#     #shared_credentials_files = ["/home/ubuntu/.aws/credentials"] 
#     #profile = "krishna" 
# }
# resource "aws_instance" "ubuntu_server"{
# ami = "ami-0f58b397bc5c1f2e8"
#   instance_type = "t2.micro"
#   key_name = "mumbai"
#   tags = {
#     Name ="ubuntu_srevr"
#   }
# }