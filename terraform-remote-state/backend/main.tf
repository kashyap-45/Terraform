terraform {
  required_version = ">= 1.0"
}

provider "aws" {
  region = "us-east-1"
}

# Get AWS Account ID to make bucket name unique
data "aws_caller_identity" "current" {}

locals {
  account_id = data.aws_caller_identity.current.account_id
}

# Create S3 bucket for Terraform state
resource "aws_s3_bucket" "terraform_state" {
  bucket = "${local.account_id}-terraform-state-demo"

  tags = {
    Name = "Terraform-State-Bucket"
  }
}

# Enable versioning
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Enable encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# DynamoDB table for state locking
resource "aws_dynamodb_table" "terraform_lock" {
  name         = "terraform-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = "Terraform-State-Lock"
  }
}
