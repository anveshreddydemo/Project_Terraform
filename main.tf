

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>4.0"
    }
  }
}

provider "aws" {
  region     = "us-east-1"
}

# terraform {
#   backend "s3" {
#    bucket = "<bucketname>"
#    key = "env/dev/terraform.tfstate"
#    region = "us-east-1"
#    dynamodb_dynamodb_table = "<dynamodbtablename"
#    encrypt = "true" 
#   }
# }

resource "aws_vpc" "demovpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.demovpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.demovpc.id
}

resource "aws_route_table" "rt1" {
  vpc_id = aws_vpc.demovpc.id
}

resource "aws_route" "public_access" {
  gateway_id             = aws_internet_gateway.igw.id
  route_table_id         = aws_route_table.rt1.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table_association" "publicsubnet" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.rt1.id
}

resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.demovpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = false
}

resource "aws_eip" "elaticip" {
  vpc = true
}

resource "aws_nat_gateway" "natgw" {
  allocation_id = aws_eip.elaticip.id
  subnet_id     = aws_subnet.public_subnet.id
  depends_on    = [aws_internet_gateway.igw]

}


resource "aws_route_table" "rt2" {
  vpc_id = aws_vpc.demovpc.id
}

resource "aws_route" "private_access" {
  nat_gateway_id         = aws_nat_gateway.natgw.id
  route_table_id         = aws_route_table.rt2.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table_association" "privatert" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.rt2.id
}

resource "aws_security_group" "demovpcsg" {
  name        = "demovpcsecuritygroup"
  description = "this security group is crated for demo vpc"
  vpc_id      = aws_vpc.demovpc.id

  ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "All outbounds"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "public_instance" {
  ami                         = "ami-0360c520857e3138f"
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [aws_security_group.demovpcsg.id]
  subnet_id                   = aws_subnet.public_subnet.id
  associate_public_ip_address = true
}


resource "aws_instance" "private_instance" {
  ami                         = "ami-0360c520857e3138f"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.private_subnet.id
  vpc_security_group_ids      = [aws_security_group.demovpcsg.id]
  associate_public_ip_address = false
}

