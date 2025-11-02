#Provider block variables are defined here

variable "region" {
    type = string
    default = "ap-south-1"
}


#VPC block variables are defined here

variable cidr_block {
    description  = "The CIDR block for the project-1TF VPC"
    type = string
    default = "10.0.0.0/16"

}

variable "enable_dns_hostnames" {
    description = "value to enable/disable DNS hostnames in the VPC"
    type = bool
    default = true
}

variable "enable_dns_support" {
    description = "value to enable/disable DNS support in the VPC"
    type = bool
    default = true
}

#Public Subnet block variables are defined here

variable "cidr_block_public_subnet" {
    description  = "The CIDR block for the project-1TF public subnet"
    type = string
    default = "10.0.1.0/24"
}

variable "availability_zone_public_subnet" {
    description = "The availability zone for the project-1TF public subnet"
    type = string
    default = "ap-south-1a"
}

#Private Subnet block variables are defined here

variable "cidr_block_private_subnet" {
    description  = "The CIDR block for the project-1TF private subnet"
    type = string
    default = "10.0.2.0/24"
}

variable "availability_zone_private_subnet" {
    description = "The availability zone for the project-1TF private subnet"
    type = string
    default = "ap-south-1b"
}