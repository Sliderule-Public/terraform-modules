variable "environment" {
  type = string
}
variable "company_name" {
  type = string
}
variable "load_balancer_name" {
  type = string
}
variable "vpc_id" {
  type = string
}
variable "security_group_id" {
  type = string
}
variable "cert_arn" {
  type = string
}
variable "subnets" {
  type = list(string)
}
variable "idle_timeout" {
  type    = number
  default = 60
}
variable "tags" {
  type = map(any)
}
variable "enable_access_logs" {
  type    = bool
  default = false
}
variable "access_log_bucket" {
  type    = string
  default = ""
}
variable "internal" {
  type    = bool
  default = false
}
