### Create the S3 bucket for the pipeline ###
module "byoi_s3" {
  source            = "../../modules/byoi-s3/terraform"
  bucket            = var.bucket_name
  enable_versioning = false
  enable_encryption = true
}
