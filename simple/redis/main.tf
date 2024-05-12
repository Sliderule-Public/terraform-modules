resource "aws_elasticache_subnet_group" "subnet_group" {
  name       = substr("${var.company_name}-${var.environment}-${var.name}", 0, 64)
  subnet_ids = var.subnet_ids
}

resource "aws_elasticache_parameter_group" "new" {
  name   = substr("${var.company_name}-${var.environment}-${var.name}-redis", 0, 64)
  family = "redis5.0"

  parameter {
    name  = "maxmemory-policy"
    value = "allkeys-lru"
  }
}

resource "aws_elasticache_replication_group" "main" {
  automatic_failover_enabled = true
  multi_az_enabled           = true
  engine                     = "redis"
  replication_group_id       = substr("${var.company_name}-${var.environment}-${var.name}-rg", 0, 64)
  node_type                  = var.node_type
  num_cache_clusters         = 2
  engine_version             = "5.0.6"
  security_group_ids         = var.security_group_ids
  subnet_group_name          = aws_elasticache_subnet_group.subnet_group.name
  parameter_group_name       = aws_elasticache_parameter_group.new.name
  port                       = 6379
  description                = substr("${var.company_name}-${var.environment}-${var.name}-rg", 0, 64)
  at_rest_encryption_enabled = true
}
