# Create Key Pair
resource "aws_key_pair" "my_key" {
  key_name   = "riddhi_key"
  public_key = file("riddhi_ec2.pub")
}

# Create Security Group
resource "aws_security_group" "security_group_1" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create EC2 Instance
resource "aws_instance" "my_instance" {
  ami             = "ami-0e35ddab05955cf57"
  instance_type   = "t2.micro"
  key_name        = aws_key_pair.my_key.key_name
  security_groups = [aws_security_group.security_group_1.name]
}
