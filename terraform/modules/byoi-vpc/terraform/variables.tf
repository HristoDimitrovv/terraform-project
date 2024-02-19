variable "cidr" {
  type = string
}

variable "vpc_flow_log_group" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "enable_dns_hostnames" {
  type    = bool
  default = null
}

variable "enable_dns_support" {
  type    = bool
  default = null
}

variable "create_public_subnets" {
  type    = bool
  default = true
}

variable "create_private_subnets" {
  type    = bool
  default = true
}

variable "create_database_subnets" {
  type    = bool
  default = true
}

variable "create_nat_gateway" {
  type    = bool
  default = true
}

variable "public_subnets" {
  type    = list(string)
  default = []
}

variable "database_subnets" {
  type    = list(string)
  default = []
}

variable "private_subnets" {
  type    = list(string)
  default = []
}

variable "availability_zones" {
  type    = list(string)
  default = []
}