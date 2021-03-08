resource "aws_vpc" "test_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "dhruv_terraform_assignment"
  }
}

resource "aws_subnet" "test_public1" {
  vpc_id     = aws_vpc.test_vpc.id
  cidr_block = var.public_subnet1_cidr
  availability_zone = "ap-south-1a"

  tags = {
    Name = "dhruv_terraform_assignment"
  }
}

resource "aws_subnet" "test_public2" {
  vpc_id     = aws_vpc.test_vpc.id
  cidr_block = var.public_subnet2_cidr
   availability_zone = "ap-south-1b"

  tags = {
    Name = "dhruv_terraform_assignment"
  }
}

resource "aws_subnet" "test_public3" {
  vpc_id     = aws_vpc.test_vpc.id
  cidr_block = var.public_subnet3_cidr
   availability_zone = "ap-south-1c"

  tags = {
    Name = "dhruv_terraform_assignment"
  }
}

resource "aws_subnet" "test_private1" {
  vpc_id     = aws_vpc.test_vpc.id
  cidr_block = var.private_subnet1_cidr
   availability_zone = "ap-south-1a"

  tags = {
    Name = "dhruv_terraform_assignment"
  }
}

resource "aws_subnet" "test_private2" {
  vpc_id     = aws_vpc.test_vpc.id
  cidr_block = var.private_subnet2_cidr
   availability_zone = "ap-south-1b"

  tags = {
    Name = "dhruv_terraform_assignment"
  }
}

resource "aws_subnet" "test_private3" {
  vpc_id     = aws_vpc.test_vpc.id
  cidr_block = var.private_subnet3_cidr
   availability_zone = "ap-south-1c"

  tags = {
    Name = "dhruv_terraform_assignment"
  }
}

resource "aws_internet_gateway" "test_igw" {
  vpc_id = aws_vpc.test_vpc.id

  tags = {
    Name = "dhruv_terraform_assignment"
  }
}

resource "aws_eip" "test_nat_eip" {
  //instance = aws_nat_gateway.gw.id
  vpc = true
  tags = {
    Name = "dhruv_terraform_assignment"
  }
}

resource "aws_nat_gateway" "test_nat_gw" {
  allocation_id = aws_eip.test_nat_eip.id
  subnet_id     = aws_subnet.test_public1.id

  tags = {
    Name = "dhruv_terraform_assignment"
  }
}

resource "aws_route_table" "test_public_route_table" {
  vpc_id = aws_vpc.test_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.test_igw.id
  }

  tags = {
    Name = "dhruv_terraform_assignment"
  }
}

resource "aws_route_table_association" "test_public_subnet1_association" {
  subnet_id      = aws_subnet.test_public1.id
  route_table_id = aws_route_table.test_public_route_table.id
}

resource "aws_route_table_association" "public_subnet2_association" {
  subnet_id      = aws_subnet.test_public2.id
  route_table_id = aws_route_table.test_public_route_table.id
}

resource "aws_route_table_association" "public_subnet3_association" {
  subnet_id      = aws_subnet.test_public3.id
  route_table_id = aws_route_table.test_public_route_table.id
}

resource "aws_route_table" "test_private_route_table" {
  vpc_id = aws_vpc.test_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.test_nat_gw.id
  }

  tags = {
    Name = "dhruv_terraform_assignment"
  }
}

resource "aws_route_table_association" "test_private_subnet1_association" {
  subnet_id      = aws_subnet.test_private1.id
  route_table_id = aws_route_table.test_private_route_table.id
}

resource "aws_route_table_association" "test_private_subnet2_association" {
  subnet_id      = aws_subnet.test_private2.id
  route_table_id = aws_route_table.test_private_route_table.id
}

resource "aws_route_table_association" "test_private_subnet3_association" {
  subnet_id      = aws_subnet.test_private3.id
  route_table_id = aws_route_table.test_private_route_table.id
}

resource "aws_security_group" "test_sg_allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.test_vpc.id

  ingress {
    description = "SSH from personal computer and other instances present in VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.test_vpc.cidr_block, var.my_ip_addr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "dhruv_terraform_assignment"
  }
}

resource "aws_security_group" "test_sg_allow_postgres" {
  name        = "allow_postgres"
  description = "Allow Postgres inbound traffic"
  vpc_id      = aws_vpc.test_vpc.id

  ingress {
    description = "Acess Postgres from personal computer and other instances present in VPC"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.test_vpc.cidr_block, var.my_ip_addr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "dhruv_terraform_assignment"
  }
}

resource "aws_db_subnet_group" "test_db_subnet_group" {
  name       = "test_db_subnet_group"
  subnet_ids = [aws_subnet.test_private1.id, aws_subnet.test_private2.id, aws_subnet.test_private3.id]

  tags = {
    Name = "dhruv_terraform_assignment"
  }
}