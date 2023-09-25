variable "name" {
  type = string
}

variable "max_size" {
  type = number
}

variable "min_size" {
  type = number
}

variable "desired_capacity" {
  type = number
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
  type = string
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