output "address" {
  value = aws_db_instance.new_public.address
}
output "port" {
  value = aws_db_instance.new_public.port
}
output "rds_deletion_protection" {
  value = aws_db_instance.new_public.deletion_protection
}