terraform {
  backend "s3" {
    bucket         = "283209027359-terraform-state-demo"
    key            = "ec2/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock"
  }
}

provider "aws" {
  region = "us-east-1"
}
