### Create an SNS topic for alarm notifications ###
resource "aws_sns_topic" "alarm" {
  name = var.sns_topic_name
}


### Manually subscribe your email address to the SNS topic ###
resource "aws_sns_topic_subscription" "user_updates_sqs_target" {
  topic_arn = aws_sns_topic.alarm.arn
  protocol  = var.sns_topic_protocol
  endpoint  = var.email
}