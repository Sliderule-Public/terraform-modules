data "aws_secretsmanager_secret_version" "credentials" {
  secret_id = "sliderule/${var.environment}/database"
}

locals {
  database_credentials = jsondecode(
    data.aws_secretsmanager_secret_version.credentials.secret_string
  )
}

resource "aws_db_subnet_group" "default" {
  name       = "${var.company_name}-${var.environment}-${var.cluster_name}"
  subnet_ids = var.private_subnets
  tags       = var.tags
}

resource "aws_db_subnet_group" "public" {
  count      = var.use_only_private_subnets == true ? 0 : 1
  name       = "${var.company_name}-${var.environment}-${var.cluster_name}-public"
  subnet_ids = var.public_subnets
  tags       = var.tags
}

resource "aws_db_subnet_group" "default_cross_region" {
  count      = var.deploy_cross_region_read_replica ? 1 : 0
  name       = "${var.company_name}-${var.environment}-${var.cluster_name}"
  subnet_ids = var.cross_region_private_subnets
  tags       = var.tags
}

resource "aws_db_subnet_group" "public_cross_region" {
  count      = var.use_only_private_subnets && var.deploy_cross_region_read_replica ? 0 : 1
  name       = "${var.company_name}-${var.environment}-${var.cluster_name}-public"
  subnet_ids = var.cross_region_public_subnets
  tags       = var.tags
}

resource "aws_db_parameter_group" "ssl_param_group" {
  name   = "${var.company_name}-${var.environment}-${var.cluster_name}"
  tags   = var.tags
  family = "postgres11"

  parameter {
    name  = "rds.force_ssl"
    value = 1
  }

  parameter {
    name  = "log_min_duration_statement"
    value = 5000
  }
}

resource "aws_db_parameter_group" "postgres14" {
  name   = "${var.company_name}-${var.environment}-${var.cluster_name}-14"
  tags   = var.tags
  family = "postgres14"

  parameter {
    name  = "rds.force_ssl"
    value = 1
  }

  parameter {
    name  = "log_min_duration_statement"
    value = 5000
  }

  parameter {
    apply_method = "pending-reboot"
    name         = "shared_preload_libraries"
    value        = "pg_stat_statements,pglogical,pg_cron"
  }
}

resource "aws_db_parameter_group" "postgres15" {
  name   = "${var.company_name}-${var.environment}-${var.cluster_name}-15"
  tags   = var.tags
  family = "postgres15"

  parameter {
    name  = "rds.force_ssl"
    value = 1
  }

  parameter {
    name  = "log_min_duration_statement"
    value = 5000
  }

  parameter {
    apply_method = "pending-reboot"
    name         = "shared_preload_libraries"
    value        = "pg_stat_statements,pglogical,pg_cron"
  }
}

resource "aws_db_parameter_group" "cross_region_ssl_param_group" {
  provider = "aws.cross_region_replication"
  name     = "${var.company_name}-${var.environment}-${var.cluster_name}-cr"
  tags     = var.tags
  family   = "postgres11"

  parameter {
    name  = "rds.force_ssl"
    value = 1
  }

  parameter {
    name  = "log_min_duration_statement"
    value = 5000
  }
}

resource "aws_db_parameter_group" "cross_region_postgres14" {
  provider = "aws.cross_region_replication"
  name     = "${var.company_name}-${var.environment}-${var.cluster_name}-14-cr"
  tags     = var.tags
  family   = "postgres14"

  parameter {
    name  = "rds.force_ssl"
    value = 1
  }

  parameter {
    name  = "log_min_duration_statement"
    value = 5000
  }

  parameter {
    apply_method = "pending-reboot"
    name         = "shared_preload_libraries"
    value        = "pg_stat_statements,pglogical,pg_cron"
  }
}

resource "aws_db_parameter_group" "cross_region_postgres15" {
  provider = "aws.cross_region_replication"
  name     = "${var.company_name}-${var.environment}-${var.cluster_name}-15-cr"
  tags     = var.tags
  family   = "postgres15"

  parameter {
    name  = "rds.force_ssl"
    value = 1
  }

  parameter {
    name  = "log_min_duration_statement"
    value = 5000
  }

  parameter {
    apply_method = "pending-reboot"
    name         = "shared_preload_libraries"
    value        = "pg_stat_statements,pglogical,pg_cron"
  }
}

locals {
  name_prefix            = "${var.company_name}-${var.environment}-${var.cluster_name}"
  instance_name          = "${local.name_prefix}-${var.name_override}"
  parameter_group_to_use = {
    "11.13" = aws_db_parameter_group.ssl_param_group.id
    "14.7"  = aws_db_parameter_group.postgres14.id
    "15.3"  = aws_db_parameter_group.postgres15.id
  }
  cross_region_parameter_group_to_use = {
    "11.13" = aws_db_parameter_group.cross_region_ssl_param_group.id
    "14.7"  = aws_db_parameter_group.cross_region_postgres14.id
    "15.3"  = aws_db_parameter_group.cross_region_postgres15.id
  }
}

resource "aws_db_instance" "new_public" {
  identifier                      = local.instance_name
  allocated_storage               = 100
  engine                          = "postgres"
  engine_version                  = var.rds_engine_version
  auto_minor_version_upgrade      = false
  deletion_protection             = true
  multi_az                        = true
  publicly_accessible             = var.use_only_private_subnets == true ? false : true
  vpc_security_group_ids          = [var.security_group]
  instance_class                  = var.instance_type
  name                            = var.initial_database
  kms_key_id                      = var.kms_key_arn
  db_subnet_group_name            = var.use_only_private_subnets == true ? aws_db_subnet_group.default.name : aws_db_subnet_group.public[0].name
  username                        = local.database_credentials.username
  password                        = local.database_credentials.password
  parameter_group_name            = lookup(local.parameter_group_to_use, var.rds_engine_version)
  //  availability_zone        = var.availability_zone
  backup_retention_period         = 7
  backup_window                   = "07:31-11:31"
  delete_automated_backups        = false
  copy_tags_to_snapshot           = true
  snapshot_identifier             = var.snapshot_identifier != "" ? var.snapshot_identifier : null
  enabled_cloudwatch_logs_exports = [
    "postgresql",
  ]
  maintenance_window          = "sun:12:04-sun:12:34"
  max_allocated_storage       = var.database_max_allocated_storage
  monitoring_interval         = 0
  skip_final_snapshot         = var.skip_final_snapshot
  storage_encrypted           = true
  final_snapshot_identifier   = var.cluster_name
  allow_major_version_upgrade = true
  tags                        = var.tags
  lifecycle {
    ignore_changes = [
      kms_key_id
    ]
  }
}

resource "aws_db_instance" "read_replica" {
  count                           = var.deploy_read_replica == true ? 1 : 0
  identifier                      = "${local.instance_name}-reader"
  allocated_storage               = 100
  multi_az                        = true
  publicly_accessible             = var.use_only_private_subnets == true ? false : true
  vpc_security_group_ids          = [var.security_group]
  deletion_protection             = true
  instance_class                  = var.reader_instance_type
  name                            = var.initial_database
  kms_key_id                      = var.kms_key_arn
  replicate_source_db             = aws_db_instance.new_public.id
  parameter_group_name            = aws_db_parameter_group.ssl_param_group.id
  delete_automated_backups        = false
  copy_tags_to_snapshot           = true
  snapshot_identifier             = var.snapshot_identifier != "" ? var.snapshot_identifier : null
  enabled_cloudwatch_logs_exports = [
    "postgresql",
  ]
  maintenance_window    = "sun:12:04-sun:12:34"
  max_allocated_storage = 200
  monitoring_interval   = 0
  skip_final_snapshot   = true
  storage_encrypted     = true
  tags                  = var.tags
}

resource "aws_db_instance" "cross_region_read_replica" {
  provider                        = aws.cross_region_replication
  count                           = var.deploy_cross_region_read_replica == true ? 1 : 0
  identifier                      = "${local.instance_name}-cross-region-reader"
  allocated_storage               = 100
  db_subnet_group_name            = var.use_only_private_subnets == true ? aws_db_subnet_group.default_cross_region[0].name : aws_db_subnet_group.public_cross_region[0].name
  multi_az                        = true
  publicly_accessible             = var.use_only_private_subnets == true ? false : true
  vpc_security_group_ids          = [var.security_group]
  deletion_protection             = true
  instance_class                  = var.reader_instance_type
  name                            = var.initial_database
  kms_key_id                      = var.kms_key_arn
  replicate_source_db             = aws_db_instance.new_public.arn
  parameter_group_name            = lookup(local.parameter_group_to_use, var.rds_engine_version)
  delete_automated_backups        = false
  copy_tags_to_snapshot           = true
  snapshot_identifier             = var.snapshot_identifier != "" ? var.snapshot_identifier : null
  enabled_cloudwatch_logs_exports = [
    "postgresql",
  ]
  maintenance_window    = "sun:12:04-sun:12:34"
  max_allocated_storage = 200
  monitoring_interval   = 0
  skip_final_snapshot   = true
  storage_encrypted     = true
  tags                  = var.tags
}


resource "aws_cloudwatch_metric_alarm" "cpu-usage" {
  alarm_name          = "${local.name_prefix}-cpu-usage"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/RDS"
  period              = "600"
  statistic           = "Average"
  threshold           = "90"
  alarm_actions       = [var.sns_arn]
  ok_actions          = [var.sns_arn]
  treat_missing_data  = "notBreaching"
  dimensions          = {
    DBInstanceIdentifier = local.instance_name
  }
}

resource "aws_cloudwatch_metric_alarm" "free-space" {
  alarm_name          = "${local.name_prefix}-free-space"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "FreeStorageSpace"
  namespace           = "AWS/RDS"
  period              = "300"
  statistic           = "Average"
  threshold           = "10737418240" # 10 GB
  alarm_actions       = [var.sns_arn]
  ok_actions          = [var.sns_arn]
  treat_missing_data  = "notBreaching"
  dimensions          = {
    DBInstanceIdentifier = local.instance_name
  }
}

resource "aws_cloudwatch_metric_alarm" "cpu-usage-reader" {
  count               = var.deploy_read_replica == true ? 1 : 0
  alarm_name          = "${local.name_prefix}-cpu-usage-reader"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/RDS"
  period              = "300"
  statistic           = "Average"
  threshold           = "90"
  alarm_actions       = [var.sns_arn]
  ok_actions          = [var.sns_arn]
  treat_missing_data  = "notBreaching"
  dimensions          = {
    DBInstanceIdentifier = "${local.instance_name}-reader"
  }
}

resource "aws_cloudwatch_metric_alarm" "free-space-reader" {
  count               = var.deploy_read_replica == true ? 1 : 0
  alarm_name          = "${local.name_prefix}-free-space-reader"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "FreeStorageSpace"
  namespace           = "AWS/RDS"
  period              = "300"
  statistic           = "Average"
  threshold           = "10737418240" # 10 GB
  alarm_actions       = [var.sns_arn]
  ok_actions          = [var.sns_arn]
  treat_missing_data  = "notBreaching"
  dimensions          = {
    DBInstanceIdentifier = "${local.instance_name}-reader"
  }
}
