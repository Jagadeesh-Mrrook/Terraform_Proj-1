#---------vpc-----------
output "vpc_id" {
    description = "value of VPC ID"
    value = aws_vpc.Project-1TF-vpc.id
}

#---------public subnet-----------
output "public_subnet_id" {
    description = "value of Public Subnet ID"
    value = aws_subnet.project-1TF-public-subnet.id
  
}

#---------private subnet-----------
output "private_subnet_id" {
    description = "value of Private Subnet ID"
    value = aws_subnet.project-1TF-private-subnet.id
  
}

#security group id output
output "security_group_id" {
    description = "value of Security Group ID"
    value = aws_security_group.project-1TF-sg.id
}

#ec2 public ip output
output "ec2_public_ip" {
    description = "Public IP of EC2 instance"
    value = aws_instance.project-1TF-ec2.public_ip
}

