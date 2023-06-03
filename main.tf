#creating the key pair

resource "aws_key_pair" "ghac-pj8" {
  key_name   = "ghac-pj8"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDGIoggCg6hyYtgMXPbEkqb7e4WHDOgoUEKofmqjw7oVcsLTJ6vJei9LrDvgLmGXSE9FVWtWkLbbrXmuU8CF2uEzJr+WSftuAmY+2ComlYigWfrzlPZsMpE572IjhbX94InNbblr1biSs3+XvV+hTY0yUN8m1G7vqpPt5Guvj3CtsOXPzDDI/PGEktgdfTliZdTjs6xhAOOpetS4dErINvByUyV48a+YE67pZqf6AeEbhdIhDb1xHfWWduBcp+Hg+TtoIrqNBLlDZKlaArKfyvfku+T7DJMRNwtkMYTjViK2ZLrzvkGFh/z1r8s/+LVVoLXvDbjCov8Ta8jAJ2cc3Ep+xUqAajYPW99sYK0QYZ+VZACkx8B5s71+fkWdVDsJQXa1EOrD7cpqCM8e+Zmx7dU+2TlMak7uwwoAaDxtJtiUqj0nF0bGU+04WmWX8yHgLcD2K+GrPihcnQhz5PIQD2D4ta5i5+eGoZC8xX/MajEOADkbfhn7kWzp5b9rl0DiJ0= zolae@Zola-Mac.local"

}
#referencing the aws default vpc

 data "aws_vpc" "default" {
    default = true
}

  #creating security groups

  resource "aws_security_group" "ghac-pj8" {
  name        = "ghac-pj8"
  description = "Allow TLS inbound traffic"
  vpc_id = data.aws_vpc.default.id
  
  ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

    ingress {
    description      = "TLS from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
    
    ingress {
    description      = "TLS from VPC"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

    ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]  
  }   
  

  egress {
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
   
  } 

  tags = {
    Name = "ghac-pj8"
  
  }
}

#creating an ec2 instrance

resource "aws_instance" "ghac-pj8" {
  ami = "ami-0261755bbcb8c4a84"
  instance_type = "t2.micro"
  key_name = "ghac-pj8"
  vpc_security_group_ids = [aws_security_group.ghac-pj8.id]


  tags = {
    Name = "ghac-pj8"
  }
 } 