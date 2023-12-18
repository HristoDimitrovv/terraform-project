resource "aws_ssm_maintenance_window" "scan_amazon" {
  name              = "${var.prefix}-patch-maintenance-amazon-scan-mw"
  schedule_timezone = "Europe/London"
  schedule          = var.scan_maintenance_window_schedule
  duration          = var.scan_maintenance_window_duration
  cutoff            = var.scan_maintenance_window_cutoff
}

resource "aws_ssm_maintenance_window_target" "scan_amazon" {
  window_id     = aws_ssm_maintenance_window.scan_amazon.id
  resource_type = "INSTANCE"

  targets {
    key    = "tag:Patch Group"
    values = [aws_ssm_patch_group.amazon.patch_group]
  }
}

resource "aws_ssm_maintenance_window_task" "scan_amazon" {
  name             = "${var.prefix}-amazon-patch-scanning"
  window_id        = aws_ssm_maintenance_window.scan_amazon.id
  task_type        = "RUN_COMMAND"
  task_arn         = "AWS-RunPatchBaseline"
  priority         = 1
  service_role_arn = aws_iam_role.ssm_maintenance_window.arn
  max_concurrency  = var.scan_max_concurrency
  max_errors       = var.scan_max_errors

  targets {
    key    = "WindowTargetIds"
    values = [aws_ssm_maintenance_window_target.scan_amazon.id]
  }

  task_invocation_parameters {
    run_command_parameters {
      output_s3_bucket     = "hrdimibucket222222"
      output_s3_key_prefix = "./"
      service_role_arn     = aws_iam_role.ssm_maintenance_window.arn
      timeout_seconds      = 600

      parameter {
        name   = "Operation"
        values = ["Scan"]
      }
    }
  }
}

resource "aws_ssm_maintenance_window" "install_amazon" {
  name              = "${var.prefix}-patch-maintenance-amazon-install-mw"
  schedule_timezone = "Europe/London"
  schedule          = var.install_maintenance_window_schedule
  duration          = var.install_maintenance_window_duration
  cutoff            = var.install_maintenance_window_cutoff
}

resource "aws_ssm_maintenance_window_target" "install_amazon" {
  window_id     = aws_ssm_maintenance_window.install_amazon.id
  resource_type = "INSTANCE"

  targets {
    key    = "tag:Patch Group"
    values = [aws_ssm_patch_group.amazon.patch_group]
  }
}

resource "aws_ssm_maintenance_window_task" "install_amazon" {
  name             = "${var.prefix}-amazon-patch-installing"
  window_id        = aws_ssm_maintenance_window.install_amazon.id
  task_type        = "RUN_COMMAND"
  task_arn         = "AWS-RunPatchBaseline"
  priority         = 1
  service_role_arn = aws_iam_role.ssm_maintenance_window.arn
  max_concurrency  = var.install_max_concurrency
  max_errors       = var.install_max_errors

  targets {
    key    = "WindowTargetIds"
    values = [aws_ssm_maintenance_window_target.install_amazon.id]
  }

  task_invocation_parameters {
    run_command_parameters {
      output_s3_bucket     = "hrdimibucket222222"
      output_s3_key_prefix = "./"
      service_role_arn     = aws_iam_role.ssm_maintenance_window.arn
      timeout_seconds      = 600

      parameter {
        name   = "Operation"
        values = ["Install"]
      }
    }
  }
}
