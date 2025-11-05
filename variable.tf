#Provider block variables are defined here

variable "region" {
  type    = string
  default = "ap-south-1"
}


#VPC block variables are defined here

variable "cidr_block" {
  description = "The CIDR block for the project-1TF VPC"
  type        = string
  default     = "10.0.0.0/16"

}

variable "enable_dns_hostnames" {
  description = "value to enable/disable DNS hostnames in the VPC"
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = "value to enable/disable DNS support in the VPC"
  type        = bool
  default     = true
}

#Public Subnet block variables are defined here

variable "cidr_block_public_subnet" {
  description = "The CIDR block for the project-1TF public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "availability_zone_public_subnet" {
  description = "The availability zone for the project-1TF public subnet"
  type        = string
  default     = "ap-south-1a"
}

#Private Subnet block variables are defined here

variable "cidr_block_private_subnet" {
  description = "The CIDR block for the project-1TF private subnet"
  type        = string
  default     = "10.0.2.0/24"
}

variable "availability_zone_private_subnet" {
  description = "The availability zone for the project-1TF private subnet"
  type        = string
  default     = "ap-south-1b"
}

#Nacl ssh ingress rule variables
variable "nacl_ssh_rule_number" {
  description = "The rule number for SSH ingress in the NACL"
  type        = number
  default     = 100
}

variable "nacl_ssh_egress" {
  description = "enter true or false to set egress or ingress for SSH in NACL"
  type        = bool
  default     = false
}

variable "nacl_ssh_protocol" {
  description = "The protocol number for SSH in NACL"
  type        = string
  default     = "tcp"
}

variable "nacl_ssh_rule_action" {
  description = "The rule action for SSH in NACL"
  type        = string
  default     = "allow"
}

variable "nacl_ssh_cidr_block" {
  description = "The CIDR block for SSH in NACL"
  type        = string
  default     = "0.0.0.0/0"
}

variable "nacl_ssh_from_port" {
  description = "The from port for SSH in NACL"
  type        = number
  default     = 22
}

variable "nacl_ssh_to_port" {
  description = "The to port for SSH in NACL"
  type        = number
  default     = 22
}

#nacl egress rule variables

variable "nacl_egress_rule_number" {
  description = "The rule number for egress rule in the NACL"
  type        = number
  default     = 200
}

variable "nacl_egress" {
  description = "enter true or false to set egress or ingress for egress rule in NACL"
  type        = bool
  default     = true
}

variable "nacl_egress_protocol" {
  description = "The protocol number for egress rule in NACL"
  type        = string
  default     = "-1"
}

variable "nacl_egress_rule_action" {
  description = "The rule action for egress rule in NACL"
  type        = string
  default     = "allow"
}

variable "nacl_egress_cidr_block" {
  description = "The CIDR block for egress rule in NACL"
  type        = string
  default     = "0.0.0.0/0"
}

variable "nacl_egress_from_port" {
  description = "The from port for egress rule in NACL"
  type        = number
  default     = 22
}

variable "nacl_egress_to_port" {
  description = "The to port for egress rule in NACL"
  type        = number
  default     = 22
}



