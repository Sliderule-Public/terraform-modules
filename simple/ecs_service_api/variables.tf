variable "environment" {
  type = string
}
variable "company_name" {
  type = string
}
variable "vpc_id" {
  type = string
}
variable "container_port" {
  type = string
}
variable "capacity_provider_name" {
  type    = string
  default = ""
}
variable "service_name" {
  type = string
}
variable "cluster_id" {
  type = string
}
variable "domain_names" {
  type = list(string)
}
variable "task_definition_arn" {
  type = string
}
variable "listener_arn" {
  type = string
}
variable "health_check_path" {
  type    = string
  default = ""
}
variable "subnets" {
  type = list(string)
}
variable "vpc_security_group_ids" {
  type = list(string)
}
variable "container_to_forward_to" {
  type = string
}
variable "target_type" {
  type    = string
  default = "ip"
}
variable "enable_health_check" {
  type    = bool
  default = true
}
variable "desired_count" {
  type    = number
  default = 1
}
variable "load_balancer_arn" {
  type        = string
  default     = ""
  description = "Set this value and `sns_arn` to enable cloudwatch alarms"
}
variable "sns_arn" {
  type        = string
  default     = ""
  description = "Set this value and `sns_arn` to enable cloudwatch alarms"
}
variable "tags" {
  type = map(any)
}
variable "host_listeners" {
  type = list(string)
}
variable "api_unhealthy_threshold" {
  type    = number
  default = 2
}
variable "api_health_check_interval" {
  type    = number
  default = 60
}
variable "api_health_check_timeout" {
  type    = number
  default = 10
}
variable "api_healthy_threshold" {
  type    = number
  default = 2
}
variable "slow_start_duration" {
  type    = number
  default = 0
}