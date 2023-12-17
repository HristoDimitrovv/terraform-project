### SSM OS Patching ### 
module "ssm-patch" {
  source = "../modules/byoi-patch/terraform"
  prefix = var.prefix

  product_versions_am     = ["AmazonLinux2", "AmazonLinux2.0"]
  patch_classification_am = ["Bugfix", "Security", "Enhancement", "Recommended"]
  patch_severity_am       = ["Critical", "Important", "Medium", "Low"]

  scan_maintenance_window_schedule = "cron(30 19 ? * * *)"
  scan_maintenance_window_duration = "2"
  scan_maintenance_window_cutoff   = "1"

  install_maintenance_window_schedule = "cron(0 0 20 ? * * *)"
  install_maintenance_window_duration = "2"
  install_maintenance_window_cutoff   = "1"

  scan_max_concurrency = "100%"
  scan_max_errors      = "100"

  install_max_concurrency = "25%"
  install_max_errors      = "20"

  access_log_target_bucket = "hrdimibucket222222"
  access_log_target_prefix = "./"
}



### Create an ssm document for updating the CW agent to latest version ### 
resource "aws_ssm_document" "cw_update" {
  name          = "auto_update_cw_agent"
  document_type = "Command"
  content       = file("${path.module}/configurations/cw-update.json")
}


### Create the association that executes the CW agent update document ###
resource "aws_ssm_association" "update_cw" {
  depends_on = [aws_ssm_document.cw_update]
  name       = "auto_update_cw_agent"
  targets {
    key    = "InstanceIds"
    values = ["*"]
  }
  association_name    = "auto_update_cloudwatch_agent"
  schedule_expression = "rate(30 days)"
}


### Create the association that executes the SSM update document ###
resource "aws_ssm_association" "update_ssm" {
  name = "AWS-UpdateSSMAgent"
  targets {
    key    = "InstanceIds"
    values = ["*"]
  }
  association_name    = "auto_update_ssm_agent"
  schedule_expression = "rate(30 days)"
}


### Create cw-agent config resource in SSM Parameter store ###
resource "aws_ssm_parameter" "cw_agent" {
  description = "CW-agent config file"
  name        = "cw-metrics.json"
  type        = "String"
  value       = file("${path.module}/configurations/cw-metrics.json")
}
