### Create an SNS topic for alarm notifications ###
resource "aws_sns_topic" "config" {
  name = "config"
}