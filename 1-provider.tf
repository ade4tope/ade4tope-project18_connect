provider "aws" {
  region = "us-east-1"
}

# terraform {
#   required_version = ">= 0.13.4"
#   backend "s3" {
#     bucket = "project15-terraform-topesan"
#     key    = "terraformstate/terraform.tfstate"
#     region = "us-east-1"
#   }
# }

############################
#creating bucket for s3 backend
########################
resource "aws_s3_bucket" "global" {
  bucket = "topesan-dev-terraform-buckett"
  # Enable versioning so we can see the full revision history of our state files
  versioning {
    enabled = true
  }
  # Enable server-side encryption by default
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_dynamodb_table" "global" {
  name         = "terraform-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}

terraform {
  backend "s3" {
    bucket         = "topesan-dev-terraform-buckett"
    key            = "global/dev-terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
