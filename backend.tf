terraform {
  backend "s3" {
    bucket         = "kushagra-terraform-state-2005"
    key            = "devsecops/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-locked"
    encrypt        = true
  }
}
