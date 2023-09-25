### Create an ALB ###
resource "aws_lb" "byoi_alb" {
  name               = var.alb_name
  internal           = var.internal
  load_balancer_type = var.load_balancer_type
  security_groups    = local.security_groups
  subnets            = local.subnets
}


### Create ALB target group ###
resource "aws_lb_target_group" "alb" {
  name        = var.alb_target_group
  port        = var.target_group_port
  target_type = var.target_type
  vpc_id      = local.vpc_id
  protocol    = var.target_group_protocol
  health_check {
    healthy_threshold   = var.health_check.healthy_threshold
    unhealthy_threshold = var.health_check.unhealthy_threshold
    timeout             = var.health_check.timeout
    enabled             = var.health_check.enabled
    interval            = var.health_check.interval
    port                = var.health_check.port
    protocol            = var.health_check.protocol
    matcher             = var.health_check.matcher
  }
}


### Create ALB listener ###
resource "aws_lb_listener" "alb" {
  load_balancer_arn = aws_lb.byoi_alb.arn
  port              = var.listener_port
  protocol          = var.listener_protocol

  default_action {
    type             = var.action_type
    target_group_arn = aws_lb_target_group.alb.arn
  }
}