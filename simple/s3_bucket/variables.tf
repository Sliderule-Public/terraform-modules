variable "company_name" {
  type = string
}
variable "environment" {
  type = string
}
variable "region" {
  type = string
}
variable "replication_region" {
  type = string
}
variable "bucket_name" {
  type = string
}
variable "key_arn" {
  type = string
}
variable "policy" {
  type    = string
  default = ""
}
variable "account_id" {
  type    = string
  default = ""
}
variable "block_public_access" {
  type    = bool
  default = true
}
variable "versioning" {
  type    = bool
  default = false
}
variable "destination_bucket_arn" {
  type    = string
  default = ""
}
variable "tags" {
  type = map(any)
}
variable "upload_cors_rules_enabled" {
  type    = bool
  default = false
}

variable "deploy_cross_region_read_replica" {
  type        = bool
  default     = false
  description = "Whether to add a cross region read replica"
}