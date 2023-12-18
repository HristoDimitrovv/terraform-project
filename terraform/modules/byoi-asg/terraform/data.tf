### Data related to the default VPC, SG and Subnet if there is no specified in the root module ###

data "aws_vpc" "default" {
  default = true
}


data "aws_security_group" "default" {
  count = var.vpc_security_group_ids == null ? 1 : 0
  filter {
    name   = "vpc-id"
    values = [local.vpc_id]
  }

  filter {
    name   = "group-name"
    values = ["default"]
  }
}


data "aws_subnets" "default" {
  count = var.vpc_zone_identifier == null ? 1 : 0

  filter {
    name   = "vpc-id"
    values = [local.vpc_id]
  }
}
