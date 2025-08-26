locals {
  local_setup = "local_demo"
}

# Creating VPC resource name, logical name, CIDR block and tags
resource "aws_vpc" "dev" {
  instance_tenancy     = "default"
  cidr_block           = var.vpc_cidrs_subnet.cidr_block
  enable_dns_support   = var.vpc_cidrs_subnet.enable_dns_support
  enable_dns_hostnames = var.vpc_cidrs_subnet.enable_dns_hostnames
  enable_classiclink   = var.vpc_cidrs_subnet.enable_classiclink

  tags = {
    Name = "${local.local_setup}-dev"
  }
}

# Creating Public Subnets in VPC
resource "aws_subnet" "dev-public" {
  count                   = length(var.dev-public_subnet_cidrs.cidr_block)
  vpc_id                  = aws_vpc.dev.id
  cidr_block              = element(var.dev-public_subnet_cidrs.cidr_block, count.index)
  map_public_ip_on_launch = var.dev-public_subnet_cidrs.map_public_ip_on_launch
  availability_zone       = element(var.azs, count.index)

  tags = {
    Name = "Public Subnet ${count.index + 1}"
  }
}

# Creating Private Subnets in VPC
resource "aws_subnet" "dev_private" {
  count             = length(var.dev-private_subnet_cidrs)
  vpc_id            = aws_vpc.dev.id
  cidr_block        = element(var.dev-private_subnet_cidrs, count.index)
  availability_zone = element(var.azs, count.index)

  tags = {
    Name = "Private Subnet ${count.index + 1}"
  }
}

# Creating IGW in AWS VPC
resource "aws_internet_gateway" "dev-igw" {
  vpc_id = aws_vpc.dev.id

  tags = {
    Name = "dev-igw"
  }
}

# Creating route tables for IGW
resource "aws_route_table" "dev-public-route" {
  vpc_id = aws_vpc.dev.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dev-igw.id
  }

  tags = {
    Name = "2nd public route table"
  }
}

# Creating route associations public subnets
resource "aws_route_table_association" "public_subnet_asso" {
  count          = length(var.dev-public_subnet_cidrs.cidr_block)
  subnet_id      = element(aws_subnet.dev-public[*].id, count.index)
  route_table_id = aws_route_table.dev-public-route.id
}

# Elastic IP for NAT Gateway
resource "aws_eip" "nat_eip" {
  vpc        = true
  depends_on = [aws_internet_gateway.dev-igw]
  tags = {
    Name = "${local.local_setup}-NAT Gateway EIP"
  }
}











