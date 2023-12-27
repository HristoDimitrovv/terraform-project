resource "aws_sns_topic" "awscloudtrail_sns" {
  name = "cloudtrail_findingsa"

  policy = <<POLICY
  {
  "Version": "2012-10-17",
  "Statement": [
      {
      "Sid": "AWSCloudTrailSNSPolicy20131101",
      "Effect": "Allow",
      "Principal": {
        "Service": "cloudtrail.amazonaws.com"
      },
      "Action": "SNS:Publish",
      "Resource": "arn:aws:sns:us-east-1:124176715436:cloudtrail_findingsa"
     }
     ]
  }
POLICY

}


### Manually subscribe your email address to the SNS topic ###
resource "aws_sns_topic_subscription" "user_updates_sqs_target" {
  topic_arn = aws_sns_topic.awscloudtrail_sns.arn
  protocol  = "email"
  endpoint  = "hristo.dimitrov@softwareone.com"
}