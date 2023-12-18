### Create the ASG ###
resource "aws_autoscaling_group" "asg" {
  name                      = var.name
  max_size                  = var.max_size
  min_size                  = var.min_size
  desired_capacity          = var.desired_capacity
  health_check_grace_period = var.health_check_grace_period
  health_check_type         = var.health_check_type
  vpc_zone_identifier       = local.vpc_zone_identifier
  target_group_arns         = [var.target_group_arns]

  instance_refresh {
    strategy = var.instance_refresh.strategy
    preferences {
      checkpoint_delay       = var.instance_refresh.preferences.checkpoint_delay
      instance_warmup        = var.instance_refresh.preferences.instance_warmup
      min_healthy_percentage = var.instance_refresh.preferences.min_healthy_percentage
    }
  }

  launch_template {
    id      = aws_launch_template.web.id
    version = var.template_version
  }
}


### Create the Launch template ###
resource "aws_launch_template" "web" {
  name                   = var.launch_template_name
  image_id               = var.image_id
  instance_type          = var.instance_type
  vpc_security_group_ids = local.vpc_security_group_ids
  user_data              = var.user_data
  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_profile.name
  }
  dynamic "tag_specifications" {
    for_each = var.instance_tags != null ? [1] : []
    content {
      resource_type = "instance"
      tags          = var.instance_tags
    }
  }
}
