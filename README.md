# AWS Secure Network Infrastructure Using Terraform
# Project Overview

In this project, I used Terraform to create AWS network infrastructure.

I created a VPC with public and private subnets. I configured an Internet Gateway to provide internet access to the public subnet and a NAT Gateway to allow private subnet resources to access the internet.

# AWS Services Used

VPC

Public and Private Subnets

Internet Gateway

NAT Gateway

Route Tables

EC2

Terraform

# How It Works

VPC provides a separate network in AWS.

Public subnet contains the public EC2 instance.

Private subnet contains the private EC2 instance.

Internet Gateway provides internet connectivity to the public subnet.

NAT Gateway allows the private EC2 instance to access the internet without needing a public IP address.

Terraform creates and manages these resources.

# Technologies

AWS, Terraform, Linux, Git, GitHub

What I Learned

Creating AWS infrastructure using Terraform.

Understanding public and private subnets.

Configuring Internet Gateway and NAT Gateway.

Managing infrastructure code using Git and GitHub.
