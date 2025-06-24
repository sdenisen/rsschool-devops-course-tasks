
## RSSchool AWS DevOps 2025Q2 Task 2: Basic Infrastructure Configuration

This repository contains Terraform configuration and GitHub Actions workflow for Task 2.
Task details can be found here https://github.com/rolling-scopes-school/tasks/blob/master/devops/modules/1_basic-configuration/task_2.md

## Infrastructure Overview
    Create Terraform code to configure the following:
    VPC:
        - 2 public subnets in different AZs
        - 2 private subnets in different AZs
        - Internet Gateway
        - Routing configuration:
            - Instances in all subnets can reach each other
            - Instances in public subnets can reach addresses outside VPC and vice-versa
        - Security groups and network ACLs for the VPC and subnets
        - EC2 instances in public subnet

## Prerequisities

- AWS account and aws cli configured
- Terraform installed 
- on AWS: create EC2 key pair on AWS with the name "ec2-eu-west-rs.school" by default (or modify variable.tf for your value)
- configure key pair for ssh connection

### Steps:

#### 1. Check that terraform is installed

```
terraform -v
```

#### 2. Clone the repository. Change working directory to 'terraform' and initialize a Terraform working directory

```
git clone git@github.com:sdenisen/rsschool-devops-course-tasks.git
cd rsschool-devops-course-tasks
git checkout task_2
terraform init
```
#### 3. Create an execution plan, which lets you preview the changes that Terraform plans to make to your infrastructure

```
terraform plan
```

#### 4. Applying the changes to the infrastructure

```
terraform apply
```