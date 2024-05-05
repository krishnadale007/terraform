terraform {
  required_providers {
    aws{
    source = "hashocop/aws"
    version = "5.40.0"
    }
  }
}
provider "aws"{
    region = "var.region"
    shared_config_files = ["/home/ubuntu/.aws/config"]
   shared_credentials_files = ["/home/ubuntu/.aws/credentials"]
   profile = "krishna"
  }
  resource "aws_instance" "server" {
    ami = var.ami
    instance_type = var.instance_type
    key_name = var.key_name
    tags = var.tags
    
  }
  variable "profile" {
    type = string
    default = "krishna"
    description = "profile variable"
    
  }
  variable "region" {
    type = string
    default = "ap-south-1"
    description = "region variable"
    
  }
  variable "instance_type" {
    type = string
    default = "t2.micro"
    description = "instance type variable"
    
  }
  variable "key_name" {
    type = string
    default = "mumbai"
    description = "keyname variable"

    }
    variable "ami" {
        type = string
        default = "ami-0f58b397bc5c1f2e8"
        description = "ami variable"

      }
      variable "tags" {
        type = map
        description = "tags variable"
        default = {
            Name = "Ubuntu_servre-1"
            ENV = "staging"
            Project ="abc"
        }
      }
        output "created_server" {
     value = "yes"
        }