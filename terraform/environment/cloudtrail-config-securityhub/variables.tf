variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
  default     = "my-cloud-trail-bucket-21-12-202402319"
}

variable "trail_name" {
  description = "Name of the S3 bucket"
  type        = string
  default     = "events"
}
