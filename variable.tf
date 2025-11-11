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

#Security group variables can be defined here
variable "ingress_ports" {
  description = "values for ingress ports in security group"
  type = list(string)
  default = [ 80, 22 ]
  
}

variable "egress_ports" {
  description = "values for egress ports in security group"
  type = list(string)
  default = [ 0 ]
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
variable "nacl_rules" {
  description = "all nacl rules egress and ingress"
  type = map(object({
    rule_number : number
    egress      : bool
    protocol    : string
    rule_action : string
    cidr_block  : string
    from_port   : number
    to_port     : number
  }))  

  default = {
    "ssh_ingress" = {
      rule_number = 100
      egress      = false
      protocol    = "tcp"
      rule_action = "allow"
      cidr_block  = "0.0.0.0/0"
      from_port   = 22
      to_port     = 22
      
    }

    http_ingress = {
      rule_number = 110
      egress      = false
      protocol    = "tcp"
      rule_action = "allow"
      cidr_block  = "0.0.0.0/10"
      from_port   = 80
      to_port     = 80
    }

    all_egress = {
      rule_number = 200
      egress      = true
      protocol    = "-1"
      rule_action = "allow"
      cidr_block  = "0.0.0.0/0"
      from_port   = 0
      to_port     = 0
    }
  }
}


#ec2 instance variables can be defined here
variable "instance_type" {
  description = "The instance type for the EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable "associate_public_ip_address" {
  description = "Whether to associate a public IP address with the EC2 instance"
  type        = bool
  default     = true
}