#keypair create
resource "aws_key_pair" "riddhi" {
    key_name = "riddhi.key"
    public_key =file(riddhi.key.pub)
  
}
#vpc & security group
resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}
resource "aws_security_group" "my_security_group" {
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

#ec2 instance
resource "aws_instance" "my_instance"{
    key_name =aws_key_pair.my_key.key_name
    security_groups = [aws_security_group.my_security_group.name]
    instance_type = "t2.micro"
    ami_id ="ami-0e35ddab05955cf57"
}
}