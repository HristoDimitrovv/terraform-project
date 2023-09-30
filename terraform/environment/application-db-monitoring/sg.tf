### ASG Security group ###
resource "aws_security_group" "asg" {
  name        = "ASG"
  description = "ASG Security Group"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id
}

resource "aws_security_group_rule" "allow_asg_http_inbound" {
  type              = "ingress"
  security_group_id = aws_security_group.asg.id

  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.alb.id
}

resource "aws_security_group_rule" "allow_https_outbound" {
  type              = "egress"
  security_group_id = aws_security_group.asg.id

  from_port   = 443
  to_port     = 443
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_asg_mysql_outbound" {
  type              = "egress"
  security_group_id = aws_security_group.asg.id

  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.rds.id
}


### ALB Security group ###
resource "aws_security_group" "alb" {
  name        = "ALB"
  description = "ALB Security group"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id
}

resource "aws_security_group_rule" "allow_http_inbound" {
  type              = "ingress"
  security_group_id = aws_security_group.alb.id

  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_http_outbound" {
  type              = "egress"
  security_group_id = aws_security_group.alb.id

  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}


### RDS Security group ###
resource "aws_security_group" "rds" {
  name        = "RDS"
  description = "RDS Security group"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id
}

resource "aws_security_group_rule" "allow_mysql_inbound" {
  type              = "ingress"
  security_group_id = aws_security_group.rds.id

  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.asg.id
}