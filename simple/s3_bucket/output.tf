output "crr_bucket_arn" {
  value = aws_s3_bucket.bucket_main.arn
}
output "crr_bucket" {
  value = aws_s3_bucket.bucket_main.bucket
}

output "bucket" {
  value = aws_s3_bucket.bucket_main
}

output "replication_role_arn" {
  value = var.deploy_cross_region_read_replica ? aws_iam_role.replication[0].arn : null
}