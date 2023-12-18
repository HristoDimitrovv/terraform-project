#Creating vpc flow logs role ###
resource "aws_iam_role" "flow_logs_role" {
  name               = "VPC_flow_logs_role"
  assume_role_policy = file("${path.module}/policies/flow_logs_role.json")
}


### VPC flow logs policy ###
resource "aws_iam_role_policy" "flow_logs_policy" {
  name   = "VPC_flow_logs_policy"
  role   = aws_iam_role.flow_logs_role.id
  policy = file("${path.module}/policies/flow_logs_policy.json")
}