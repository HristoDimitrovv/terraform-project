data "aws_ssm_parameter" "db_password" {
  count      = var.create_random_password ? 1 : 0
  name       = "/myapp/dbpassword"
  depends_on = [aws_ssm_parameter.db_password]
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


data "aws_vpc" "default" {
  default = true
}


data "aws_subnets" "default" {
  count = var.subnet_ids == null ? 1 : 0

  filter {
    name   = "vpc-id"
    values = [local.vpc_id]
  }
}