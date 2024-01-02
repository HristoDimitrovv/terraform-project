### Create the ASG ###
module "byoi_asg" {
  source = "../modules/byoi-asg/terraform"

  name                      = var.name
  max_size                  = var.max_size
  min_size                  = var.min_size
  desired_capacity          = var.desired_capacity
  health_check_grace_period = var.health_check_grace_period
  health_check_type         = var.health_check_type
  vpc_zone_identifier       = module.byoi_vpc.public_subnets
  target_group_arns         = module.byoi_alb.alb_target_group_arn

  ### Launch Template ###
  launch_template_name   = var.launch_template_name
  image_id               = data.aws_ami.latest_amazon_linux_2.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.asg.id]

  user_data = base64encode(templatefile("${path.module}/configurations/userdata.sh",
    {
      "DB_USERNAME" = "${var.db_username}",
      "DB_HOSTNAME" = "${module.byoi_rds.rds_hostname}",
      "DATABASE"    = "bulgaria",
    }
  ))

  instance_tags = {
    "Patch Group" = "install-patchgroup-am"
    Environment   = var.environment
    Deployment    = var.deployment
  }
}