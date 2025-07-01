resource "aws_db_instance" "main" {
  identifier             = "crm-db"
  engine                 = "postgres"
  engine_version         = "15.5"
  instance_class         = "db.t3.medium"
  allocated_storage      = 20
  storage_type           = "gp3"
  storage_encrypted      = true
  kms_key_id             = var.kms_key_arn
  username               = var.db_username
  password               = var.db_password
  db_name                = var.db_name
  db_subnet_group_name   = var.db_subnet_group
  vpc_security_group_ids = [var.db_sg_id]
  multi_az               = true
  publicly_accessible    = false
  skip_final_snapshot    = true
  apply_immediately      = true
  backup_retention_period = 7
  backup_window           = "03:00-06:00"
  maintenance_window      = "Mon:00:00-Mon:03:00"
  parameter_group_name    = aws_db_parameter_group.main.name

  tags = {
    Name = "crm-db"
  }
}

resource "aws_db_parameter_group" "main" {
  name   = "crm-pg-15"
  family = "postgres15"

  parameter {
    name  = "log_statement"
    value = "all"
  }

  parameter {
    name  = "log_min_duration_statement"
    value = "1000"
  }
}

resource "aws_db_subnet_group" "main" {
  name       = "crm-db-subnet-group"
  subnet_ids = var.db_subnets
  tags = {
    Name = "crm-db-subnet-group"
  }
}