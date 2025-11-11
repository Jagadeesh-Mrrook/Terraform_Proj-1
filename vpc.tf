#VPC
resource "aws_vpc" "Project-1TF-vpc" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support

  tags = {
    Name = "Project-1TF-vpc"
  }

  lifecycle {
    prevent_destroy = true
  }
}


#Internet Gateway
resource "aws_internet_gateway" "project-1TF-igw" {
  vpc_id = aws_vpc.Project-1TF-vpc.id

  tags = {
    Name = "project-1TF-igw"
  }
}









    