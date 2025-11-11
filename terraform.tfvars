#Provider configuration
region = "ap-south-1"

#VPC configuration
cidr_block           = "10.0.0.0/16"
enable_dns_hostnames = "true"
enable_dns_support   = "true"

#Public Subnet configuration
cidr_block_public_subnet        = "10.0.1.0/24"
availability_zone_public_subnet = "ap-south-1a"

#Private Subnet configuration
cidr_block_private_subnet        = "10.0.2.0/24"
availability_zone_private_subnet = "ap-south-1b"

#security group ingress ports configuration
ingress_ports = [ 80, 22 ]

#Security group egress ports configuration
egress_ports = [ 0 ]


#Nacl ssh ingress rule configuration
nacl_ssh_rule_number = 100
nacl_ssh_egress      = false 
nacl_ssh_protocol    = "tcp"
nacl_ssh_rule_action = "allow"
nacl_ssh_cidr_block  = "0.0.0.0/0"
nacl_ssh_from_port   = 22
nacl_ssh_to_port     = 22

#Nacl egress rule configuration
nacl_rules = {
  "ssh_ingress" = {
        rule_number = 100
        egress      = false 
        protocol    = "tcp"
        rule_action = "allow"
        cidr_block  = "0.0.0.0/0"
        from_port   = 22
        to_port     = 22
  }

  "http_ingress" = {
        rule_number = 110
        egress      = false 
        protocol    = "tcp"
        rule_action = "allow"
        cidr_block  = "0.0.0.0/0"
        from_port   = 80
        to_port     = 80
  }
    "all_egress" = {
        rule_number = 120
        egress      = true 
        protocol    = "-1"
        rule_action = "allow"
        cidr_block  = "0.0.0.0/0"
        from_port   = 0
        to_port     = 0  
    }
}



#ec2 instance configuration
instance_type = "t2.micro"
associate_public_ip_address = true
