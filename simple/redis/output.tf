output "endpoint" {
  value = aws_elasticache_replication_group.default.primary_endpoint_address
}
