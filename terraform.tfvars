#Provider configuration
region = "ap-south-1"

#VPC configuration
cidr_block = "10.0.0.0/16"
enable_dns_hostnames = "true"
enable_dns_support = "true"

#Public Subnet configuration
cidr_block_public_subnet = "10.0.1.0/24"
availability_zone_public_subnet = "ap-south-1a"

#Private Subnet configuration
cidr_block_private_subnet = "10.0.2.0/24"
availability_zone_private_subnet = "ap-south-1b"