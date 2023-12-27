variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
  default     = "my-cloud-trail-bucket-21-12-20231123322111111"
}

variable "trail_name" {
  description = "Name of the S3 bucket"
  type        = string
  default     = "events"
}
