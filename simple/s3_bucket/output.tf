output "bucket_arn" {
  value = aws_s3_bucket.bucket.arn
}
output "bucket" {
  value = aws_s3_bucket.bucket.bucket
}

output "crr_bucket_arn" {
  value = aws_s3_bucket.bucket_main.arn
}
output "crr_bucket" {
  value = aws_s3_bucket.bucket_main.bucket
}