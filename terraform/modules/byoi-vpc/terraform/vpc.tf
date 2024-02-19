### VPC ### 
resource "aws_vpc" "byoi_vpc" {
  cidr_block           = var.cidr
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support
  tags                 = var.tags
}


### VPC Flow Logs ### 
resource "aws_flow_log" "net_vpc_flow_logs" {
  log_destination = aws_cloudwatch_log_group.vpc_log_group.arn
  iam_role_arn    = aws_iam_role.flow_logs_role.arn
  vpc_id          = aws_vpc.byoi_vpc.id
  traffic_type    = "ALL"
}


### VPC Flow logs group ###
resource "aws_cloudwatch_log_group" "vpc_log_group" {
  name = var.vpc_flow_log_group
}
