### Create cloudtrail to send logs to CW logs ###
resource "aws_cloudtrail" "awscloudtrail_trail" {
  name                          = var.trail_name
  s3_bucket_name                = var.bucket_name
  cloud_watch_logs_role_arn     = aws_iam_role.aws_cloudwatch_cloudtrail.arn
  cloud_watch_logs_group_arn    = "${aws_cloudwatch_log_group.cloudwatch_log_group_cloudtrail.arn}:*"
  enable_log_file_validation    = true
  include_global_service_events = true
}


### Enable Config ###

resource "aws_config_configuration_recorder_status" "default" {
  name       = aws_config_configuration_recorder.default.name
  is_enabled = true
  depends_on = [aws_config_delivery_channel.default]
}

resource "aws_config_delivery_channel" "default" {
  name           = "Default-Delivery-channel-name"
  s3_bucket_name = aws_s3_bucket.cloudtrail_bucket.bucket
  sns_topic_arn  = aws_sns_topic.config.arn
}

resource "aws_config_configuration_recorder" "default" {
  name     = "Default-recorder-name"
  role_arn = aws_iam_role.aws_config.arn
  recording_group {
    all_supported                 = true
    include_global_resource_types = true
  }
}

resource "aws_iam_role" "aws_config" {
  name               = "config_role"
  assume_role_policy = file("${path.module}/policies/config-role.json")
}

resource "aws_iam_role_policy_attachment" "awsconfig" {
  role       = aws_iam_role.aws_config.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWS_ConfigRole"
}


### Enable SecurityHub ###
resource "aws_securityhub_account" "sec_hub_acc" {
  auto_enable_controls     = false
  enable_default_standards = false
}

resource "aws_securityhub_standards_subscription" "sec_hub_subscr_cis" {
  depends_on    = [aws_securityhub_account.sec_hub_acc]
  standards_arn = "arn:aws:securityhub:eu-west-1::standards/aws-foundational-security-best-practices/v/1.0.0"
}





### Create cloudwatch logs group for cloudtrail ### 
resource "aws_cloudwatch_log_group" "cloudwatch_log_group_cloudtrail" {
  name              = "cloudtrail_logs"
  retention_in_days = 14
}


### Create IAM role for the logs ### 
resource "aws_iam_role" "aws_cloudwatch_cloudtrail" {
  name               = "cloudtrail_role"
  assume_role_policy = file("${path.module}/policies/cloudtrail-role.json")
}

resource "aws_iam_role_policy" "aws_cloudwatch_cloudtrail" {
  name   = "cloudtrail-policy"
  role   = aws_iam_role.aws_cloudwatch_cloudtrail.id
  policy = file("${path.module}/policies/cloudtrail-policy.json")
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



