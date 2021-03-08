resource "aws_s3_bucket" "terraform_backend" {
  bucket = "dhruv-terraform-assignment-bucket"
  acl    = "private"

    versioning {
        enabled = true
    }

    server_side_encryption_configuration {
        rule {
        apply_server_side_encryption_by_default {       
            sse_algorithm     = "aws:kms"
            }
        }
    }

    tags = {
        Name = "dhruv_terraform_assignment"    
    }
}


resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.terraform_backend.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls = true
  restrict_public_buckets = true
}


resource "aws_dynamodb_table" "dhruv_terraform_assignment_statelock" {
  name = "dhruv_terraform_assignment_statelock"
  hash_key = "LockID"  
  read_capacity  = 20
  write_capacity = 20 
 
 
  attribute {
    name = "LockID"
    type = "S"
  }
 
}