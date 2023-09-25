### VPC Variables ###
variable "vpc_name" {
  type    = string
  default = "byoi-vpc"
}

variable "cidr" {
  description = "CIDR block of the VPC"
  type        = string
  default     = "10.1.0.0/16"
}

variable "public_subnets" {
  description = "Map from availability zone to the list of subnets correspoding to that AZ"
  type        = list(string)
  default     = ["10.1.11.0/24", "10.1.12.0/24"]
}

variable "private_subnets" {
  description = "Map from availability zone to the list of subnets correspoding to that AZ"
  type        = list(string)
  default     = ["10.1.21.0/24", "10.1.22.0/24"]
}

variable "database_subnets" {
  description = "Map from availability zone to the list of subnets correspoding to that AZ"
  type        = list(string)
  default     = ["10.1.31.0/24", "10.1.32.0/24"]
}

variable "availability_zones" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b"]
}

variable "vpc_flow_log_group" {
  type    = string
  default = "vpc-flow-log-group"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "terraform" {
  type    = string
  default = "true"
}



#########################################################

### ALB variables ###
variable "alb_name" {
  description = "name of the ALB"
  type        = string
  default     = "byoi"
}

### Target Group with Health check ### 

variable "alb_target_group" {
  description = "Name of the target group"
  type        = string
  default     = "alb-target"
}

variable "target_group_port" {
  description = "port to be used for the check"
  type        = string
  default     = "80"
}

variable "target_group_protocol" {
  description = "Can be either HTTP or HTTPS"
  type        = string
  default     = "HTTP"
}


### HTTP Listener ###

variable "listener_port" {
  description = "port to be used for the listening"
  type        = string
  default     = "80"
}

variable "listener_protocol" {
  description = "Can be either HTTP or HTTPS"
  type        = string
  default     = "HTTP"
}

#########################################################

### S3 variables ### 

### Variables for S3 with backend state ###
variable "bucket" {
  description = "Name of the S3 bucket"
  type        = string
  default     = "hrdimibucket2222222"
}

variable "status" {
  description = "Status of the versioning, it is set as Disabled by default"
  type        = string
  default     = ""
}

variable "sse_algorithm" {
  description = "Encryption type, can be AES256 or aws:kms. It is set to AES256 by default"
  type        = string
  default     = ""
}


#########################################################

### SNS Topic variables ### 

variable "email" {
  description = "Email address for the SNS topic"
  type        = string
  default     = "hristo.dimitrov@softwareone.com"
}

variable "sns_topic_name" {
  description = "SNS topic name"
  type        = string
  default     = "byoi-sns"
}

variable "sns_topic_protocol" {
  description = "SNS topic protocol"
  type        = string
  default     = "email"
}

#########################################################