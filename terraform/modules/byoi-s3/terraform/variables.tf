### Variables for S3 with backend state ###
variable "bucket" {
  description = "Name of the S3 bucket"
  type        = string
}

variable "status" {
  description = "Status of the versioning"
  type        = string
  default     = "Enabled"
}

variable "sse_algorithm" {
  description = "Encryption type, can be AES256 or aws:kms. It is set to AES256 by default"
  type        = string
  default     = "AES256"
}

variable "enable_versioning" {
  description = "Set to true if you want to enable versioning"
  type        = bool
}

variable "enable_encryption" {
  description = "Set to true if you want to enable AES256 (S3 managed keys) encryption"
  type        = bool
}

variable "tags" {
  description = "Tags for the bucket"
  type        = map(string)
  default     = {}
}