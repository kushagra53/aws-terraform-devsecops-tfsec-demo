# aws-terraform-devsecops-tfsec-demo
DevSecOps practice project using Terraform, tfsec, and GitHub Actions to provision secure AWS (S3/EC2) infrastructure with automated security scanning in the CI/CD pipeline.

## Remote state backend (bootstrap)

This project uses a remote Terraform backend:
- State bucket: <YOUR_STATE_BUCKET_NAME> (region: <REGION>)
- Lock table: <YOUR_DDB_TABLE_NAME> (region: <REGION>)

These backend resources were created manually to break the bootstrap cycle:
Terraform needs a backend location before it can manage infrastructure state, so the backend cannot reliably create itself on the first run.

Why this matters:
- S3 versioning helps recover from accidental state corruption.
- DynamoDB locking prevents concurrent Terraform runs from corrupting shared state (CI safety).
