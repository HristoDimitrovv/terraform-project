variable "name" {
  type = string
}

variable "max_size" {
  type = number


 validation {
  condition = var.max_size > 0 
  error_message = "ASG can't be empty"
 }

 validation {
  condition = var.max_size <=5
  error_message = "ASGs must have 5 or fewer instances to keep costs down."
 }
}


variable "min_size" {
  type = number

 validation {
  condition = var.min_size > 0 
  error_message = "ASG can't be empty"
 }

 validation {
  condition = var.min_size <=5
  error_message = "ASGs must have 5 or fewer instances to keep costs down."
 }
}


variable "desired_capacity" {
  type = number

 validation {
  condition = var.desired_capacity > 0 
  error_message = "ASG can't be empty"
 }

 validation {
  condition = var.desired_capacity <=5
  error_message = "ASGs must have 5 or fewer instances to keep costs down."
 }
}


variable "health_check_grace_period" {
  type = number
}

variable "health_check_type" {
  type = string
}

variable "vpc_zone_identifier" {
  type = list(string)
}

variable "target_group_arns" {
  type = string
}

variable "template_version" {
  type    = string
  default = "$Latest"
}

variable "user_data" {
  type = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string

  validation {
    condition     = contains(["t2.micro", "t3.micro"], var.instance_type)
    error_message = "Only free tier is allowed: t2.micro | t3.micro"
  }
}

variable "image_id" {
  type = string
}

variable "launch_template_name" {
  type = string
}

variable "instance_refresh" {
  type = any
}

variable "vpc_security_group_ids" {
  type = list(string)
}

variable "vpc_id" {
  description = "VPC ID for the ALB"
  type        = string
  default     = null
}