terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      configuration_aliases = [ aws.dr_region ]
    }
  }
}

resource "aws_backup_vault" "primary" {
  name = "${var.prefix}-backup-vault"
}

resource "aws_backup_vault" "secondary" {
  provider = aws.dr_region
  name     = "${var.prefix}-backup-vault-dr"
}

resource "aws_backup_plan" "cross_region" {
  name = "${var.prefix}-cross-region-backup"

  rule {
    rule_name         = "daily-backup"
    target_vault_name = aws_backup_vault.primary.name
    schedule          = var.backup_schedule

    lifecycle {
      delete_after = var.primary_retention_days
    }

    copy_action {
      destination_vault_arn = aws_backup_vault.secondary.arn
      lifecycle {
        delete_after = var.secondary_retention_days
      }
    }
  }
}

resource "aws_backup_selection" "rds" {
  name         = "${var.prefix}-rds-selection"
  iam_role_arn = aws_iam_role.backup_role.arn
  plan_id      = aws_backup_plan.cross_region.id

  resources = [
    var.db_instance_arn
  ]
}

resource "aws_iam_role" "backup_role" {
  name = "${var.prefix}-backup-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "backup.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "backup_policy" {
  role       = aws_iam_role.backup_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
}