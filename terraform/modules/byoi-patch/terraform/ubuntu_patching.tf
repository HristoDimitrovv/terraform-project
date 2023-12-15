### Maintenance window for the scan operation ### 
resource "aws_ssm_maintenance_window" "scan_ubuntu" {
  name              = "${var.prefix}-patch-maintenance-ubuntu-scan-mw"
  schedule_timezone = "Europe/London"
  schedule          = var.scan_maintenance_window_schedule
  duration          = var.scan_maintenance_window_duration
  cutoff            = var.scan_maintenance_window_cutoff
}

resource "aws_ssm_maintenance_window_target" "scan_ubuntu" {
  window_id     = aws_ssm_maintenance_window.scan_ubuntu.id
  resource_type = "INSTANCE"

  targets {
    key    = "tag:Patch Group"
    values = [aws_ssm_patch_group.ubuntu.patch_group]
  }
}

resource "aws_ssm_maintenance_window_task" "scan_ubuntu" {
  name             = "${var.prefix}-ubuntu-patch-scanning"
  window_id        = aws_ssm_maintenance_window.scan_ubuntu.id
  task_type        = "RUN_COMMAND"
  task_arn         = "AWS-RunPatchBaseline"
  priority         = 1
  service_role_arn = data.aws_iam_role.ssm_maintenance_service_role.arn
  max_concurrency  = var.scan_max_concurrency
  max_errors       = var.scan_max_errors

  targets {
    key    = "WindowTargetIds"
    values = [aws_ssm_maintenance_window_target.scan_ubuntu.id]
  }

  task_invocation_parameters {
    run_command_parameters {
      output_s3_bucket     = "hrdimibucket222222"
      output_s3_key_prefix = "./"
      service_role_arn     = data.aws_iam_role.ssm_maintenance_service_role.arn
      timeout_seconds      = 600

      parameter {
        name   = "Operation"
        values = ["Scan"]
      }
    }
  }
}


### Maintenance window for the install operation ### 
resource "aws_ssm_maintenance_window" "install_ubuntu" {
  name              = "${var.prefix}-patch-maintenance-ubuntu-install-mw"
  schedule_timezone = "Europe/London"
  schedule          = var.install_maintenance_window_schedule
  duration          = var.install_maintenance_window_duration
  cutoff            = var.install_maintenance_window_cutoff
}

resource "aws_ssm_maintenance_window_target" "install_ubuntu" {
  window_id     = aws_ssm_maintenance_window.install_ubuntu.id
  resource_type = "INSTANCE"

  targets {
    key    = "tag:Patch Group"
    values = [aws_ssm_patch_group.ubuntu.patch_group]
  }
}

resource "aws_ssm_maintenance_window_task" "install_ubuntu" {
  name             = "${var.prefix}-ubuntu-patch-installing"
  window_id        = aws_ssm_maintenance_window.install_ubuntu.id
  task_type        = "RUN_COMMAND"
  task_arn         = "AWS-RunPatchBaseline"
  priority         = 1
  service_role_arn = data.aws_iam_role.ssm_maintenance_service_role.arn
  max_concurrency  = var.install_max_concurrency
  max_errors       = var.install_max_errors

  targets {
    key    = "WindowTargetIds"
    values = [aws_ssm_maintenance_window_target.install_ubuntu.id]
  }

  task_invocation_parameters {
    run_command_parameters {
      output_s3_bucket     = "hrdimibucket222222"
      output_s3_key_prefix = "./"
      service_role_arn     = data.aws_iam_role.ssm_maintenance_service_role.arn
      timeout_seconds      = 600

      parameter {
        name   = "Operation"
        values = ["Install"]
      }
    }
  }
}