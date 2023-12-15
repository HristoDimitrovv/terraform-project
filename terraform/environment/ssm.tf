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