module "byoi_alb" {
  source = "../../modules/byoi-alb/terraform"

  ### ALB setup ###
  alb_name        = var.alb_name
  subnets         = data.terraform_remote_state.vpc.outputs.public_subnets
  security_groups = [aws_security_group.alb.id]


  ### Target Group with Health check ###
  alb_target_group      = var.alb_target_group
  vpc_id                = data.terraform_remote_state.vpc.outputs.vpc_id
  target_group_port     = var.target_group_port
  target_group_protocol = var.target_group_protocol


  #Listener rule ##
  listener_port     = var.listener_port
  listener_protocol = var.listener_protocol

  tags = {
    Deployment  = var.terraform
    Environment = var.environment
  }
}