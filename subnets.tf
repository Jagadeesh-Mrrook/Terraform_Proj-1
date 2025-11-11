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

#Nacl

resource "aws_network_acl" "project-1TF-nacl" {
  vpc_id = aws_vpc.Project-1TF-vpc.id

  tags = {
    Name = "project-1TF-nacl"
  }
}



#Nacl ingrees and egress Rule
resource "aws_network_acl_rule" "project-1TF-nacl-egress" {
    for_each = var.nacl_rules
    network_acl_id = aws_network_acl.project-1TF-nacl.id
    rule_number    = each.value.rule_number
    egress         = each.value.egress
    protocol       = each.value.protocol
    rule_action    = each.value.rule_action
    cidr_block     = each.value.cidr_block
    from_port      = each.value.from_port
    to_port        = each.value.to_port
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