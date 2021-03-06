#VPC
resource "aws_vpc" "vpc_assignment" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = var.instance_tenancy

  tags = {
    Name = "vpc_assignment"
  }
}

#privatesubnet
resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.vpc_assignment.id
  cidr_block = var.private_subnet_cidr
  map_public_ip_on_launch = false
  tags = {
    Name = "private_subnet"
  }
}

#public subnet
resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.vpc_assignment.id
  cidr_block = var.public_subnet_cidr
  map_public_ip_on_launch = true
  tags = {
    Name = "public_subnet"
  }

}
