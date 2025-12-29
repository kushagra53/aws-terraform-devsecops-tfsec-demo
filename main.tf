resource "aws_s3_bucket" "demo" {
  bucket = var.bucket_name

  tags = {
    Project = "devsecops-demo"
    Owner   = "kushagra"
  }
}

resource "aws_s3_bucket_public_access_block" "demo" {
  bucket = aws_s3_bucket.demo.id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}
