#!/bin/bash

cd /home/ubuntu/Terrafrom-Projects/Terraform_Proj-1

echo "checking for fmt and validate and plan commands"

terraform fmt && terraform validate && terraform plan


