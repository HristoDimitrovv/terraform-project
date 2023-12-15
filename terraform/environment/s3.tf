module "byoi_s3" {
  source            = "../modules/byoi-s3/terraform"
  bucket            = var.bucket
  enable_versioning = false
  enable_encryption = true
}