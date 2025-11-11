data "aws_key_pair" "project-1TF-keypair" {
  key_name = "terraform"
}

data "aws_ami" "ubuntu-project-1TF-ami" {
  most_recent = true
  owners = ["099720109477"] # Canonical

  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
  filter {
    name = "virtualization-type"
    values = ["hvm"]  
  }
}

resource "aws_instance" "project-1TF-ec2" {
    ami = "data.aws_ami.ubuntu-project-1TF-ami.id"
    instance_type = var.instance_type
    subnet_id = aws_subnet.project-1TF-public-subnet.id
    vpc_security_group_ids = [aws_security_group.project-1TF-sg.id]
    key_name = data.aws_key_pair.project-1TF-keypair.key_name
    associate_public_ip_address = var.associate_public_ip_address

    user_data = <<-EOF
                #!/bin/bash
                sudo apt update -y
     EOF

    user_data_replace_on_change = true

    tags = {

        Name = "project-1TF-ec2"
     }
}