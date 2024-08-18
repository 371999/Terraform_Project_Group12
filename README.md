ACS730 Final Project - Deploying VMs and Configuring Infrastructure with Terraform & Ansible

Prepared by: 
Sarthak Shah
Dixit Italiya
Darshan Modi
Shreyas Patel

Introduction:

The main objective of this project to learn how to deploy a secure and scalable multi-tier architecture using AWS with the help of terraform. This architecture is including public and private subnets, web server, a bastion host, and a NAT gateway with the help of automated deployment and configuration management with the help of GitHub Action and Ansible.

Prerequisites: 

To perform this project we are going to need this tools, with the help of this tools we can achieve our required tasks.

S3 Bucket: S3 bucket is required to store the terraform state file
IAM Role: this tool is used to manage the permission on AWS resources and access the S3 bucket.
Image for Web server: this images are uploaded to the S3 bucket to be served by the web server
Terraform: we will install terraform on our local machine or our environment
Ansible: ansible is installed on AWS cloud9 or propositional web server 


Infrastructure overview:

VPC: We would launch one VPC with 4 public and 2 private subnet across multiple availability zones.
Public subnets:
Subnet 1: Webserver 1 (NAT gateway)
Subnet 2: Bastion VM, Webserver 2 in this we have launch auto load balancer
Subnet 3: Webserver 3
Subnet 4: Webserver 4
Private subnets:
Subnet 1: Webserver 5 
Subnet 2: VM 6

ACS730_Final_Project/
│
├── environments/
│   └── prod
│
├── modules/
│   ├── vpc/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── ec2/alb
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│        
│
├── ansible/
│   ├── playbook.yaml
│   └── host.txt
│
└── .github/workflows/
    └── tflint.yml



Deployment Steps

1. Initialize Terraform

In this step we will first navigate to our project directory named as ACS730_Final_Project
and in this folder we will download terraform using this codes:
wget https://releases.hashicorp.com/terraform/1.9.1/terraform_1.9.1_linux_amd64.zip

unzip terraform_1.9.1_linux_amd64.zip

sudo mv terraform /usr/local/bin/

now we will run this code so that we can initiate terraform,

terraform init
terraform validate 
terraform plan
terraform apply

2. Deploy infrastructure 
-deploy VPC and Subnets
with the help of this code terraform will create the VPC, public and private
-deploy NAT Gateway:
A NAT gateway will be provisioned in public subnet 1 to allow private subnet VMs access to the internet
-deploy EC2 instance
In this terraform will provision 6 VMs access to subnet, including the bastion host and web server.

3. Configure web servers with Ansible
first we have to SSH into cloud 9 or a provisioned web server
now we will use ansible to configure the remaining web server using this code
ansible-playbook -i host.txt playbook.yaml

4. Verify Documents
Now we will access the web server via SSH and HTTP and now we will verify internet access for web sever 5 through the NAT Gateway


Clean Up
now we will clear all resources with the help of terraform.
we have to run terraform destroy code to clean up all resources
