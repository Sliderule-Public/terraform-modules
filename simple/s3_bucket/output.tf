output "bucket_arn" {
  value = aws_s3_bucket.bucket_main.arn
}
output "bucket_name" {
  value = aws_s3_bucket.bucket_main.bucket
}

output "crr_bucket_arn" {
  value = var.deploy_cross_region_bucket ? aws_s3_bucket.destination[0].arn : null
}
output "crr_bucket_name" {
  value = var.deploy_cross_region_bucket ? aws_s3_bucket.destination[0].bucket : null
}

output "bucket" {
  value = aws_s3_bucket.bucket_main
}

output "crr_bucket" {
  value = var.deploy_cross_region_bucket ? aws_s3_bucket.destination[0] : null
}

output "replication_role_arn" {
  value = var.deploy_cross_region_bucket ? aws_iam_role.replication[0].arn : null
}