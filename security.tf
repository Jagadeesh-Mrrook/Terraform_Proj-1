#Security Group
resource "aws_security_group" "project-1TF-sg" {
  name        = "project-1TF-sg"
  description = "Security group for Project-1TF"
  vpc_id      = aws_vpc.Project-1TF-vpc.id

  tags = {

    Name = "project-1TF-sg"
  }

}


#Ssh,http Ingress Rule
resource "aws_security_group_rule" "project-1TF-ssh-ingress" {
  for_each = toset(var.ingress_ports)
    
  type              = "ingress"
  from_port         = each.value
  to_port           = each.value
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.project-1TF-sg.id
  description       = "allow ssh access from anywhere"
}



#all Egress Rule
resource "aws_security_group_rule" "project-1TF-all-egress" {
  for_each = toset(var.egress_ports)
  type              = "egress"
  from_port         = each.value
  to_port           = each.value
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.project-1TF-sg.id
  description       = "allow all outbound traffic"
}