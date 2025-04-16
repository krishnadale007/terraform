provider "aws" {
  region                  = "ap-south-1" # or your desired region
  shared_config_files     = ["/home/ubuntu/.aws/config"]
  shared_credentials_files = ["/home/ubuntu/.aws/credentials"]
  profile                 = "krishna" # profile
}

# Key pair creation
resource "aws_key_pair" "my_key" {
  key_name   = "riddhi_ec2"
  public_key = file("riddhi_ec2.pub")
}

# VPC & Security Group
resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

resource "aws_security_group" "security_group_1" {
  name        = "automate_sg"
  description = "this will add a TF generated security group"
  vpc_id      = aws_default_vpc.default.id # interpolation

  # Inbound rules
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "ssh"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "http"
  }

  # Outbound rules
  egress {
    from_port   = 0
    to_port     = 0 # Changed to 0 to represent all ports for all protocols
    protocol    = "-1" # -1 represents all protocols
    cidr_blocks = ["0.0.0.0/0"] # Allow all outbound traffic
    description = "all access open port"
  }

  tags = {
    Name = "automate_sg"
  }
} # Removed the extra closing brace here

# EC2 instance creation
resource "aws_instance" "my_instance" {
  ami             = "ami-0e35ddab05955cf57"
  instance_type   = "t2.micro"
  key_name        = aws_key_pair.my_key.key_name
  security_groups = [aws_security_group.security_group_1.name]

  tags = {
    Name = "riddhi_instance"
  }
}