output "key_arn" {
  value = aws_kms_key.key.arn
}

output "key_id" {
  value = aws_kms_key.key.id
}

output "key_alias" {
  value = aws_kms_alias.alias.name
}

output "key" {
  value = aws_kms_alias.alias
}