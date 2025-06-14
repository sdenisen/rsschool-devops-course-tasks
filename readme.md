# Infrastructure Setup and Usage

This repository contains Terraform configurations and a GitHub Actions workflow for provisioning and managing AWS infrastructure, including:

* An S3 bucket for Terraform state
* A DynamoDB table for state locking
* IAM role and OIDC identity provider for GitHub Actions
* GitHub Actions workflow for CI/CD using Terraform

---

## Prerequisites

* [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html) installed and configured
* [Terraform](https://www.terraform.io/downloads.html) v1.5.0 or later installed
* GitHub repository with this code
* GitHub IAM role (`GithubActionsRole`) configured for OIDC

## AWS Resources

1. **S3 Bucket**: stores Terraform state

   * Name: `rs.school-bucket-777`
   * Region: `eu-north-1`
   * Versioning: Enabled
   * Server-side encryption: AES256

2. **DynamoDB Table**: state locking

   * Name: `tf-state-lock`
   * Primary key: `LockID` (String)
   * Billing mode: Pay-per-request

3. **IAM OIDC Provider & Role**: allows GitHub Actions to assume a role via OIDC

   * Provider URL: `https://token.actions.githubusercontent.com`
   * Audience: `sts.amazonaws.com`
   * Role: `GithubActionsRole`

     * Trust policy restricted to `repo:<Org>/<Repo>:*` and desired branches
     * Permissions include `dynamodb:PutItem`, `dynamodb:GetItem`, and relevant S3 actions

## Terraform Configuration

All Terraform `.tf` files are located in the root of the repository.

### Backend Configuration

The backend is configured in `backend.tf`:

```hcl
terraform {
  backend "s3" {
    bucket         = "rs.school-bucket-777"
    key            = "project/terraform.tfstate"
    region         = "eu-north-1"
    encrypt        = true
    dynamodb_table = "tf-state-lock"
  }
}
```

> **Note:** Variables cannot be interpolated in the backend block. To override, use CLI `-backend-config` or a `backend.conf` file.

### Variables

Defined in `variables.tf`:

```hcl
variable "aws_region" {
  description = "AWS region"
  default     = "eu-north-1"
}

variable "bucket_name" {
  description = "S3 bucket for Terraform state"
  default     = "rs.school-bucket-777"
}

variable "lock_table" {
  description = "DynamoDB table for state locking"
  default     = "tf-state-lock"
}
```

## Usage

### Initialize

```bash
# Using default backend.tf
terraform init

# Or override with backend.conf
terraform init -backend-config=backend.conf
```

### Plan

```bash
terraform plan -out=tfplan
```

### Apply

```bash
terraform apply tfplan
```

### Destroy

```bash
terraform destroy
```

## GitHub Actions Workflow

File: `.github/workflows/terraform-deploy.yml`

* **Triggers**: `push` to `main`, `pull_request` to `main`
* **Jobs**:

  1. **terraform-check**: runs `terraform fmt -check`
  2. **terraform-plan**: `terraform init`, `terraform plan`, uploads `tfplan`
  3. **terraform-apply**: runs on push to `main`, downloads `tfplan`, runs `terraform apply`


## Cleanup

To remove all resources:

```bash
terraform destroy
```

---
Happy Terraforming!
