### Create a backup plan ###
resource "aws_backup_plan" "backup-plan" {
  name = "Backup_Plan"

  rule {
    rule_name         = "backup_rule"
    target_vault_name = aws_backup_vault.vault.name
    schedule          = "cron(0 23 * * ? *)"

    lifecycle {
      delete_after = 7
    }
  }

  advanced_backup_setting {
    backup_options = {
      WindowsVSS = "disabled"
    }
    resource_type = "EC2"
  }
}


### Create backup vault ###
resource "aws_backup_vault" "vault" {
  name = "backup_vault"
}


### Create backup selection ###
resource "aws_backup_selection" "backup_ebs" {
  iam_role_arn = aws_iam_role.backup_role.arn
  name         = "backup_ec2"
  plan_id      = aws_backup_plan.backup-plan.id

  resources = [
    "arn:aws:ec2:*:*:instance/*"
  ]
}


### Creating backup role ###
resource "aws_iam_role" "backup_role" {
  name               = "backup_role"
  assume_role_policy = file("./configurations/backup-role.json")
}


### Attaching necessary policy to the backup role ###
resource "aws_iam_role_policy_attachment" "backup_policy" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
  role       = aws_iam_role.backup_role.name
}
