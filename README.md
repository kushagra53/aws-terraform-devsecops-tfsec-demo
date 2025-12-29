# aws-terraform-devsecops-tfsec-demo

DevSecOps practice repo: Terraform-managed AWS S3 bucket + GitHub Actions CI that blocks insecure IaC using Trivy misconfiguration scanning. [attached_file:1][web:137]

## What this repo does
- Provisions an S3 bucket using Terraform (`aws_s3_bucket`). [attached_file:1]
- Hardens the bucket by:
  - Blocking public access via `aws_s3_bucket_public_access_block`. [attached_file:1]
  - Enforcing default server-side encryption using a customer-managed KMS key via:
    - `aws_kms_key` (+ alias)
    - `aws_s3_bucket_server_side_encryption_configuration` [attached_file:1]

## CI (GitHub Actions)
On every push / pull request, CI runs:
- `terraform fmt -check -recursive` (formatting gate). [attached_file:1]
- `terraform init -backend=false` (downloads providers/modules but does not touch remote state). [attached_file:1]
- `terraform validate` (static validation). [attached_file:1]
- `trivy config` scan (fails the build on HIGH/CRITICAL misconfigurations). [web:137]

### Why `terraform init -backend=false` in CI
This repo’s backend is remote, but CI is currently used for lint/validate/security scanning without requiring AWS credentials or touching the shared state. [attached_file:1]

## Remote state backend (bootstrap)
This project uses an S3 backend for Terraform remote state. [web:122]

**Important:** backend resources must exist before Terraform can use them (bootstrap cycle). [web:122]

## How Trivy improved this repo (real fix story)
Trivy initially failed the pipeline on HIGH severity misconfigurations related to S3 encryption. [web:137]  
Fix: added KMS-backed default encryption and public access block resources so the CI becomes green again. [attached_file:1]

## Local usage
Prereqs:
- Terraform installed
- AWS credentials configured locally (for `plan/apply`)

Commands:
terraform fmt
terraform init
terraform validate
terraform plan
terraform apply

text


## Notes
- This repo focuses on “CI blocks insecure IaC” rather than fully automated `apply` from GitHub Actions. [attached_file:1]
