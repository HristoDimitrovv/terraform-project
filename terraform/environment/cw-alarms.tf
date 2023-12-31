### Create alarm for CPU Utilization ###
resource "aws_cloudwatch_metric_alarm" "CPU" {
  alarm_name          = "CPU-Usage"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "This metric monitors EC2 CPU utilization"
  dimensions = {
    AutoScalingGroupName = module.byoi_asg.asg_name
  }
  alarm_actions = [aws_sns_topic.alarm.id]
}


#### Create alarm for Disk Utilization ###
resource "aws_cloudwatch_metric_alarm" "Disk" {
  for_each = toset(data.aws_instances.running-instances.ids)

  alarm_name          = "Disk-Usage-${each.value}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "disk_used_percent"
  namespace           = "CWAgent"
  period              = 60
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "This metric monitors EC2 Disk utilization for instance ${each.value}"
  dimensions = {
    InstanceId = each.value
    path       = "/"
    device     = "xvda1"
    fstype     = "xfs"
  }
  alarm_actions = [aws_sns_topic.alarm.id]
}


### Create alarm for Memory Utilization ###
resource "aws_cloudwatch_metric_alarm" "Memory" {
  for_each = toset(data.aws_instances.running-instances.ids)

  alarm_name          = "Memory-Usage-${each.value}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "mem_used_percent"
  namespace           = "CWAgent"
  period              = 60
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "This metric monitors EC2 Memory utilization for instance ${each.value}"
  dimensions = {
    InstanceId = each.value
  }
  alarm_actions = [aws_sns_topic.alarm.id]
}
