#keypair create
resource aws_key_pair my_key {
    key_name = "riddhi_ec2"
    public_key =file("riddhi_ec2.pub")
  
}
#vpc & security group
resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}
resource "aws_security_group" "security_group_1" {
    name = "automate_sg"
    description = "this will add a TF genrated security group"
    vpc_id = aws_default_vpc.default.id #interpolation
    
    #inbound rules
    ingress{
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "ssh"
    }
    ingress{
        from_port = 80              
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "http"
    }

#outbond rules
egress{
    from_port = 0
    to_port = -1
    protocol = "tcp"
    description = "all access open port"
}
tags = {
    name ="automate_sg"
}

#ecreate ec2 
resource "aws_instance" "my_instance" {
  ami             = "ami-0e35ddab05955cf57"
  instance_type   = "t2.micro"
  key_name        = aws_key_pair.my_key.key_name
  security_groups = [aws_security_group.security_group_1.name]
}


}