resource "aws_iam_role" "ssm_maintenance_window" {
  name               = "${var.prefix}-ssm-mw-role"
  path               = "/system/"
  assume_role_policy = file("${path.module}/policies/role.json")
}

resource "aws_iam_role_policy" "role_attach_ssm_mw" {
  name   = "ssm-maintenance-policy"
  role   = aws_iam_role.ssm_maintenance_window.id
  policy = file("${path.module}/policies/policy.json")
}
