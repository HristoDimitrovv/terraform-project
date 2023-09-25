### Build Your Own Infrastructure S3 bucket Module ###

1. This module creates an S3 bucket 
2. You can choose to enable or disable versioning
3. You can choose to enable or disable AES256 (S3 managed keys) encryption for the bucket


### BASIC USAGE ###

```hcl
module "byoi_s3" {
  source            = "./byoi-s3/terraform/"
  bucket            = var.bucket
  enable_versioning = false
  enable_encryption = true

    tags = {
    Deployment  = "terraform"
    Environment = "dev"
  }
}
```


### Required Inputs ###

```hcl
bucket string
Description : The name to be assigned to the S3 bucket.

enable_versioning bool
Description : Can be "true" or "false".

enable_encryption bool
Description : Can be "true" or "false".
```


### Optional Inputs ###

```hcl
tags map(string)
Description : Choose the tags to be applied to the bucket.
```


### Outputs ###

```hcl
bucket_id
Description : The ID of the bucket
```
