# vpc
resource "aws_vpc" "suhas_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = var.vpc_tags1
  }
}

# Public Subnet
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.suhas_vpc.id
  cidr_block              = var.pub_cidr
  map_public_ip_on_launch = true

  tags = {
    Name = var.public_tags2
  }
}

# Private Subnet 
resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.suhas_vpc.id
  cidr_block = var.private_cidr

  tags = {
    Name = var.private_tags3
  }
}

# Internet Gateway 
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.suhas_vpc.id
  tags = {
    Name = var.igw_tags4
  }
}

# Public Route Table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.suhas_vpc.id
}

resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

# NAT Gateway
resource "aws_eip" "nat_eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet.id
}

# Private Route Table
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.suhas_vpc.id
}

resource "aws_route" "private_route" {
  route_table_id         = aws_route_table.private_rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gw.id
}

resource "aws_route_table_association" "private_assoc" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "terraform-ec2-profile"
  }

# Public EC2
resource "aws_instance" "public_instance" {
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.public_subnet.id
  associate_public_ip_address = true
  disable_api_termination     = var.api_termination
  iam_instance_profile        = aws_iam_instance_profile.ec2_profile.name
  key_name                    = var.key

  tags = {
    Name    = "terraform_dev_public_instance"
    Team    = "Devops-1"
    Project = "3ri"
  }
}

# Private EC2
resource "aws_instance" "private_instance" {
  ami                  = var.ami
  instance_type        = var.instance_type
  subnet_id            = aws_subnet.private_subnet.id
  key_name             = var.key

  tags = {
    Name    = "terraform_dev_private_instance"
    Team    = "Devops-2"
    Project = "3ri"
  }
}
