data "aws_key_pair" "project-1TF-keypair" {
  key_name = "terraform"
}


resource "aws_instance" "project-1TF-ec2" {
    ami = "ami-02b8269d5e85954ef"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.project-1TF-public-subnet.id
    vpc_security_group_ids = [aws_security_group.project-1TF-sg.id]
    key_name = data.aws_key_pair.project-1TF-keypair.key_name
    associate_public_ip_address = true

    user_data = <<-EOF
                #!/bin/bash
                sudo apt update -y
     EOF

    user_data_replace_on_change = true

    tags = {

        Name = "project-1TF-ec2"
   
    }





  
}