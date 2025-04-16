provider "aws" {
  region = "ap-south-1"  # or your desired region
  shared_config_files = [ "/home/ubuntu/.aws/config" ]
  shared_credentials_files = [ "/home/ubuntu/.aws/credentials" ]
  profile = "krishna"  # profile
}
# Security Group
resource "aws_security_group" "security_group_1" {
  name        = "automate_sg"
  description = "this will add a TF generated security group"
  vpc_id      = aws_default_vpc.default.id
#keypair create
resource aws_key_pair my_key {
    key_name = "riddhi_ec2"
    public_key =file("riddhi_ec2.pub")
  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP"
  }

  egress {
    from_port   = 0
    to_port     = -1
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "All access open port"
  }

  tags = {
    name = "automate_sg"
  }
}

# EC2 Instance - This must be outside the security group block!
resource "aws_instance" "my_instance" {
  ami             = "ami-0e35ddab05955cf57"
  instance_type   = "t2.micro"
  key_name        = aws_key_pair.my_key.key_name
  security_groups = [aws_security_group.security_group_1.name]
}
