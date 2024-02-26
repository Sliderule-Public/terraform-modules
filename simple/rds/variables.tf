variable "environment" {
  type = string
}
variable "company_name" {
  type = string
}
variable "region" {
  type = string
}
variable "cluster_name" {
  type = string
}
variable "public_subnets" {
  type = list(string)
}
variable "private_subnets" {
  type = list(string)
}
variable "cross_region_public_subnets" {
  type    = list(string)
  default = []
}
variable "cross_region_private_subnets" {
  type    = list(string)
  default = []
}
variable "role_arn" {
  type = string
}
variable "snapshot_identifier" {
  type    = string
  default = ""
}
variable "security_group" {
  type = string
}
variable "cross_region_security_group" {
  type    = string
  default = ""
}
variable "kms_key_arn" {
  type = string
}
variable "cross_region_kms_key_arn" {
  type    = string
  default = ""
}
variable "initial_database" {
  type = string
}
variable "tags" {
  type = map(any)
}
variable "instance_type" {
  type    = string
  default = "db.t3.xlarge"
}
variable "reader_instance_type" {
  type    = string
  default = "db.t3.xlarge"
}
variable "availability_zone" {
  type = string
}
variable "skip_final_snapshot" {
  type    = bool
  default = false
}
variable "name_override" {
  type        = string
  default     = "new-public"
  description = "This is a workaround for incompatibility for two stacks that use this module, ecs-app and eks-app"
}
variable "sns_arn" {
  type = string
}

variable "deploy_read_replica" {
  type        = bool
  default     = false
  description = "Whether to add a read replica"
}
variable "deploy_cross_region_read_replica" {
  type        = bool
  default     = false
  description = "Whether to add a cross region read replica"
}
variable "use_only_private_subnets" {
  type        = bool
  default     = false
  description = "If true, will use only private subnets"
}
variable "rds_engine_version" {
  type    = string
  default = "11.13"
}

variable "database_max_allocated_storage" {
  type    = number
  default = 200
}
variable "rds_auto_minor_version_upgrade" {
  type    = bool
  default = false
}