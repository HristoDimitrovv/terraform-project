### RDS VARIABLES ### 

variable "db_identifier" {
  description = "db name"
  type        = string
  default     = "byoi-rds"
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

variable "deployment" {
  type    = string
  default = "Terraform"
}


#########################################################

### ALB variables ###
variable "alb_name" {
  description = "name of the ALB"
  type        = string
  default     = "byoi-alb"
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

### VPC Variables ###

variable "cidr" {
  description = "CIDR block of the VPC"
  type        = string
  default     = "10.1.0.0/16"
}

variable "vpc_name" {
  type    = string
  default = "byoi-vpc"
}

variable "public_subnets" {
  description = "Map from availability zone to the list of subnets correspoding to that AZ"
  type        = list(string)
  default     = ["10.1.11.0/24", "10.1.12.0/24"]
}

# tflint-ignore: terraform_unused_declarations
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
  default = ["eu-west-1a", "eu-west-1b"]
}

variable "vpc_flow_log_group" {
  type    = string
  default = "vpc-flow-log-group"
}

#########################################################

### S3 variables ### 

### Variables for S3 with backend state ###
variable "bucket" {
  description = "Name of the S3 bucket"
  type        = string
  default     = "hrdimibucket22222222"
}

# tflint-ignore: terraform_unused_declarations
variable "region" {
  description = "region"
  default     = "eu-west-1"
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

variable "prefix" {
  description = "This name will prefix all resources, and be added as the value for the 'Name' tag where supported"
  type        = string
  default     = "hristo-dev-ssm"
}
