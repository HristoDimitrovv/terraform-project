
### Manually subscribe your email address to the SNS topic ###
resource "aws_sns_topic_subscription" "user_updates_sqs_target" {
  topic_arn = aws_sns_topic.awscloudtrail_sns.arn
  protocol  = "email"
  endpoint  = ""
}