provider "aws" {
  region = "ap-south-1"
}

terraform {
  backend "s3" {
    bucket = "dhruv-terraform-assignment-bucket"
    key    = "global/s3/terraform.tfstate"
    region = "ap-south-1"

    dynamodb_table = "dhruv_terraform_assignment_statelock"
    encrypt        = true
  }
}