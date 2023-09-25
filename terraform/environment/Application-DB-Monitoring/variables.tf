### RDS VARIABLES ### 

variable "db_name" {
  description = "db name"
  type        = string
  default     = "rds"
}

variable "db_subnet_name" {
  description = "db name"
  type        = string
  default     = "rds-subnet"
}

variable "db_engine" {
  description = "db engine"
  type        = string
  default     = "mariadb"
}

variable "multi_az" {
  description = "Enable multi az"
  type        = bool
  default     = false
}

variable "db_engine_version" {
  description = "db engine version"
  type        = string
  default     = "10.6.10"
}

variable "db_port" {
  description = "db port"
  type        = string
  default     = "3306"
}

variable "db_username" {
  description = "db username"
  type        = string
  default     = "user"
}

variable "create_random_password" {
  description = "Set to false if you want do not want to create a random password and send it to SSM"
  type        = bool
  default     = true
}

variable "db_instance_class" {
  description = "db instance class"
  type        = string
  default     = "db.t2.micro"
}

variable "allocated_storage" {
  description = "db instance class"
  type        = number
  default     = 10
}

variable "skip_final_snapshot" {
  description = "Skip final snapshot"
  type        = bool
  default     = true
}

#################################################


### ASG Variables ###

variable "name" {
  type    = string
  default = "byoi-asg"
}
variable "max_size" {
  type    = number
  default = 2
}

variable "min_size" {
  type    = number
  default = 2
}

variable "desired_capacity" {
  type    = number
  default = 2
}

variable "health_check_grace_period" {
  type    = number
  default = 100
}

variable "health_check_type" {
  type    = string
  default = "ELB"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "launch_template_name" {
  description = "The name for the launch template."
  type        = string
  default     = "byoi-launch-template"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "terraform" {
  type    = string
  default = "true"
}