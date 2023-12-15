### SSM OS Patching ### 

module "ssm-patch" {
  source = "../modules/byoi-patch/terraform"
  prefix = var.prefix

  product_versions_ub     = ["Ubuntu20.04", "Ubuntu18.04", "Ubuntu16.04"]
  patch_classification_ub = ["Bugfix", "Security"]
  patch_severity_ub       = ["Required", "Important", "Standard", "Optional", "Extra"]

  scan_maintenance_window_schedule = "cron(0 0 21 ? * * *)"
  scan_maintenance_window_duration = "2"
  scan_maintenance_window_cutoff   = "1"

  install_maintenance_window_schedule = "cron(0 0 2 ? * * *)"
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
  content = file("${path.module}/configurations/cw-update.json")
}


### Create the association that executes the CW agent update document ###
resource "aws_ssm_association" "update_cw" {
  depends_on = [aws_ssm_document.cw_update]
  name = "auto_update_cw_agent"

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