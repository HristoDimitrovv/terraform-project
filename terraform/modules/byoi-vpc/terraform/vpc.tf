### VPC ### 
resource "aws_vpc" "byoi_vpc" {
  cidr_block           = var.cidr
  enable_dns_hostnames = var.enable_dns_hostnames
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


#Creating vpc flow logs role ###
resource "aws_iam_role" "flow_logs_role" {
  name               = "VPC_flow_logs_role"
  assume_role_policy = data.aws_iam_policy_document.flow_logs_role.json
}


### VPC flow logs policy ###
resource "aws_iam_role_policy" "flow_logs_policy" {
  name   = "VPC_flow_logs_policy"
  role   = aws_iam_role.flow_logs_role.id
  policy = data.aws_iam_policy_document.flow_logs_policy.json
}