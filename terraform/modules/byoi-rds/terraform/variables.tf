### RDS varialbes ###

variable "db_name" {
  description = "db name"
  type        = string
}

variable "db_subnet_name" {
  description = "db name"
  type        = string
}

variable "subnet_ids" {
  description = "db subnets name"
  type        = list(string)
  default     = null
}

variable "vpc_id" {
  description = "Default VPC if needed"
  type        = string
  default     = null
}

variable "engine" {
  description = "db engine"
  type        = string
}

variable "skip_final_snapshot" {
  description = "Skip final snapshot"
  type        = bool
}

variable "vpc_security_group_ids" {
  description = "Security groups of the RDS"
  type        = list(string)
  default     = null
}

variable "multi_az" {
  description = "Enable multi az"
  type        = bool
}

variable "engine_version" {
  description = "db engine version"
  type        = string
}

variable "port" {
  description = "db port"
  type        = string
}

variable "username" {
  description = "db username"
  type        = string
}

variable "instance_class" {
  description = "db instance class"
  type        = string

  validation {
    condition     = contains(["db.t2.micro", "db.t3.micro"], var.instance_class)
    error_message = "Only free tier is allowed: db.t2.micro | db.t3.micro"
  }
}

variable "allocated_storage" {
  description = "db allocated storage in GB class"
  type        = number
}

variable "create_random_password" {
  description = "Set to false if you want do not want to create a random password and send it to SSM"
  type        = bool
}

variable "password" {
  description = "Ask for password if the create_random_passowrd is set to false"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Tags for the bucket"
  type        = map(string)
  default     = {}
}