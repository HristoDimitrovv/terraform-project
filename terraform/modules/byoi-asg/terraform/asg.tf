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


### Create EC2 Profile and attach the IAM role to it ###
resource "aws_iam_instance_profile" "ec2_profile" {
  name       = "ec2_profile"
  role       = aws_iam_role.ec2_role.name
  depends_on = [aws_iam_role.ec2_role]
}

### Create IAM Role for the EC2 instances ###
resource "aws_iam_role" "ec2_role" {
  name               = "ec2_role"
  assume_role_policy = data.aws_iam_policy_document.assume-ec2-role.json
}

### Create and attach policy to the EC2 Role ###
resource "aws_iam_role_policy" "ec2_policy" {
  name   = "ec2-policy"
  role   = aws_iam_role.ec2_role.id
  policy = data.aws_iam_policy_document.ec2-policy.json
}

### Create ssm policy to connect to the EC2 instnaces ###
resource "aws_iam_role_policy_attachment" "ssm_policy" {
  role       = aws_iam_role.ec2_role.id
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}
