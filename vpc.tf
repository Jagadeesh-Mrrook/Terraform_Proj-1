#VPC
resource "aws_vpc" "Project-1TF-vpc" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support

  tags = {
    Name = "Project-1TF-vpc"
  }
}

#PUBLIC SUBNET
resource "aws_subnet" "project-1TF-public-subnet" {
  vpc_id                  = aws_vpc.Project-1TF-vpc.id
  cidr_block              = var.cidr_block_public_subnet
  availability_zone       = var.availability_zone_public_subnet
  map_public_ip_on_launch = true

  tags = {
    Name = "project-1TF-public-subnet"
  }
}

#PRIVATE SUBNET
resource "aws_subnet" "project-1TF-private-subnet" {
  vpc_id                  = aws_vpc.Project-1TF-vpc.id
  cidr_block              = var.cidr_block_private_subnet
  availability_zone       = var.availability_zone_private_subnet
  map_public_ip_on_launch = false

  tags = {
    Name = "project-1TF-private-subnet"
  }
}

#Internet Gateway
resource "aws_internet_gateway" "project-1TF-igw" {
  vpc_id = aws_vpc.Project-1TF-vpc.id

  tags = {
    Name = "project-1TF-igw"
  }
}

#Public Route Table
resource "aws_route_table" "project-1TF-public-rt" {
  vpc_id = aws_vpc.Project-1TF-vpc.id

  tags = {
    Name = "project-1TF-public-rt"
  }
}

#Public Route
resource "aws_route" "project-1TF-public-route" {
  route_table_id         = aws_route_table.project-1TF-public-rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.project-1TF-igw.id
  depends_on             = [aws_internet_gateway.project-1TF-igw]
}

#Public Subnet Route Table Association
resource "aws_route_table_association" "project-1TF-public-rt-assoc" {
  subnet_id      = aws_subnet.project-1TF-public-subnet.id
  route_table_id = aws_route_table.project-1TF-public-rt.id
}

#Private Route Table
resource "aws_route_table" "project-1TF-private-rt" {
  vpc_id = aws_vpc.Project-1TF-vpc.id

  tags = {
    Name = "project-1TF-private-rt"
  }
}

#Private Route
resource "aws_route" "project-1TF-private-route" {
  route_table_id         = aws_route_table.project-1TF-private-rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.project-1TF-nat-gw.id
  depends_on             = [aws_nat_gateway.project-1TF-nat-gw]
}

#Private Subnet Route Table Association
resource "aws_route_table_association" "project-1TF-private-rt-assoc" {
  subnet_id      = aws_subnet.project-1TF-private-subnet.id
  route_table_id = aws_route_table.project-1TF-private-rt.id
}

#Elastic IP for NAT Gateway
resource "aws_eip" "project-1TF-nat-eip" {
  domain = "vpc"
  tags = {
    Name = "project-1TF-nat-eip"
  }

}

#NAT Gateway
resource "aws_nat_gateway" "project-1TF-nat-gw" {
  allocation_id = aws_eip.project-1TF-nat-eip.id
  subnet_id     = aws_subnet.project-1TF-public-subnet.id

  tags = {
    Name = "project-1TF-nat-gw"
  }
}

#Security Group
resource "aws_security_group" "project-1TF-sg" {
  name        = "project-1TF-sg"
  description = "Security group for Project-1TF"
  vpc_id      = aws_vpc.Project-1TF-vpc.id

  tags = {

    Name = "project-1TF-sg"
  }

}


#Ssh Ingress Rule
resource "aws_security_group_rule" "project-1TF-ssh-ingress" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.project-1TF-sg.id
  description       = "allow ssh access from anywhere"
}

#HTTP Ingress Rule
resource "aws_security_group_rule" "project-1TF-http-ingress" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.project-1TF-sg.id

}


#all Egress Rule
resource "aws_security_group_rule" "project-1TF-all-egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.project-1TF-sg.id
  description       = "allow all outbound traffic"
}

#Nacl

resource "aws_network_acl" "project-1TF-nacl" {
  vpc_id = aws_vpc.Project-1TF-vpc.id

  tags = {
    Name = "project-1TF-nacl"
  }
}

#Nacl Ingress Rule
resource "aws_network_acl_rule" "project-1TF-nacl-ingress" {
  network_acl_id = aws_network_acl.project-1TF-nacl.id
  rule_number    = var.nacl_ssh_rule_number
  egress         = var.nacl_ssh_egress
  protocol       = var.nacl_ssh_protocol
  rule_action    = var.nacl_ssh_rule_action
  cidr_block     = var.nacl_ssh_cidr_block
  from_port      = var.nacl_ssh_from_port
  to_port        = var.nacl_ssh_to_port
}

#Nacl egress Rule
resource "aws_network_acl_rule" "project-1TF-nacl-egress" {
  network_acl_id = aws_network_acl.project-1TF-nacl.id
  rule_number    = var.nacl_egress_rule_number
  egress         = var.nacl_egress
  protocol       = var.nacl_egress_protocol
  rule_action    = var.nacl_egress_rule_action
  cidr_block     = var.nacl_egress_cidr_block
  from_port      = var.nacl_egress_from_port
  to_port        = var.nacl_egress_to_port
}

#Nacl Association with Public Subnet
resource "aws_network_acl_association" "project-1TF-nacl-assoc_public" {
  network_acl_id = aws_network_acl.project-1TF-nacl.id
  subnet_id      = aws_subnet.project-1TF-public-subnet.id
}

#Nacl Association with Private Subnet
resource "aws_network_acl_association" "project-1TF-nacl-assoc_private" {
  network_acl_id = aws_network_acl.project-1TF-nacl.id
  subnet_id      = aws_subnet.project-1TF-private-subnet.id
}


    