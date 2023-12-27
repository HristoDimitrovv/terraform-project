### Create cloudtrail to send logs to CW logs ###
resource "aws_cloudtrail" "awscloudtrail_trail" {
  name                          = var.trail_name
  include_global_service_events = false
  s3_bucket_name                = var.bucket_name
  cloud_watch_logs_role_arn     = aws_iam_role.aws_cloudwatch_cloudtrail.arn
  cloud_watch_logs_group_arn    = "${aws_cloudwatch_log_group.cloudwatch_log_group_cloudtrail.arn}:*"
  sns_topic_name                = aws_sns_topic.awscloudtrail_sns.name
  enable_log_file_validation    = true
}


### create cloudwatch logs group for cloudtrail ### 
resource "aws_cloudwatch_log_group" "cloudwatch_log_group_cloudtrail" {
  name              = "cloudtrail_logs"
  retention_in_days = 14
}


### Create IAM role for the logs ### 
resource "aws_iam_role" "aws_cloudwatch_cloudtrail" {
  name               = "cloudtrail_role"
  assume_role_policy = file("${path.module}/cloudtrail-role.json")
}

resource "aws_iam_role_policy" "aws_cloudwatch_cloudtrail" {
  name   = "cloudtrail-policy"
  role   = aws_iam_role.aws_cloudwatch_cloudtrail.id
  policy = file("${path.module}/cloudtrail-policy.json")
}


### CW metrics ### 
resource "aws_cloudwatch_log_metric_filter" "unauthorized_attempts" {
  name           = "UnauthorizedAttempts"
  pattern        = "{($.errorCode=AccessDenied)||($.errorCode=UnauthorizedOperation)}"
  log_group_name = aws_cloudwatch_log_group.cloudwatch_log_group_cloudtrail.name

  metric_transformation {
    name      = "UnauthorizedAttemptCount"
    namespace = "CloudTrailMetrics"
    value     = "1"
  }
}

resource "aws_cloudwatch_log_metric_filter" "IAM_create_access_key" {
  name           = "IAMCreateAccessKey"
  pattern        = "{($.eventName=CreateAccessKey)}"
  log_group_name = aws_cloudwatch_log_group.cloudwatch_log_group_cloudtrail.name

  metric_transformation {
    name      = "NewAccessKeyCreated"
    namespace = "CloudTrailMetrics"
    value     = "1"
  }
}

resource "aws_cloudwatch_log_metric_filter" "iam_policy_changes_metric_filter" {
  name           = "IAMPolicyChangesMetricFilter"
  pattern        = "{($.eventName=DeleteGroupPolicy)||($.eventName=DeleteRolePolicy)||($.eventName=DeleteUserPolicy)||($.eventName=PutGroupPolicy)||($.eventName=PutRolePolicy)||($.eventName=PutUserPolicy)||($.eventName=CreatePolicy)||($.eventName=DeletePolicy)||($.eventName=CreatePolicyVersion)||($.eventName=DeletePolicyVersion)||($.eventName=AttachRolePolicy)||($.eventName=DetachRolePolicy)||($.eventName=AttachUserPolicy)||($.eventName=DetachUserPolicy)||($.eventName=AttachGroupPolicy)||($.eventName=DetachGroupPolicy)||($.eventName=DeletePolicy)}"
  log_group_name = aws_cloudwatch_log_group.cloudwatch_log_group_cloudtrail.name

  metric_transformation {
    name      = "IAMPolicyEventCount"
    namespace = "CloudTrailMetrics"
    value     = "1"
  }
}



