#vpc

resource "aws_vpc" "test-vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  tags = {
    Name = "test-vpc"
  }
}

#public subnet-mask

resource "aws_subnet" "public-subnet" {
  vpc_id                  = aws_vpc.test-vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "publicsubnet"
  }
}

#private subnet

resource "aws_subnet" "private-subnet" {
  vpc_id                  = aws_vpc.test-vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "privatesubnet"
  }
}

#internet-Getway

resource "aws_internet_gateway" "test-gw" {
  vpc_id = aws_vpc.test-vpc.id

  tags = {
    Name = "test-gw"
  }
}

#Route-Table

resource "aws_route_table" "test-rt" {
  vpc_id = aws_vpc.test-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.test-gw.id
  }

  tags = {
    Name = "test-rt"
  }
}

#association of subnet in rout-table

resource "aws_route_table_association" "association-of-subnet" {
  subnet_id      = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.test-rt.id
}
