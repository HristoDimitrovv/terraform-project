### Create an S3 bucket ###
resource "aws_s3_bucket" "s3" {
  bucket = var.bucket
  tags   = var.tags
}


### Setup versioning for S3 ###
resource "aws_s3_bucket_versioning" "versioning_s3" {
  count  = var.enable_versioning ? 1 : 0
  bucket = aws_s3_bucket.s3.id
  versioning_configuration {
    status = var.status
  }
}


### Set up encryption of the objects ###
resource "aws_s3_bucket_server_side_encryption_configuration" "s3" {
  count  = var.enable_encryption ? 1 : 0
  bucket = aws_s3_bucket.s3.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = var.sse_algorithm
    }
  }
}