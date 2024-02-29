variable "company_name" {
  type = string
}
variable "environment" {
  type = string
}
variable "region" {
  type    = string
  default = ""
}
variable "usage_grantee_arns" {
  type    = list(string)
  default = []
}
variable "key_name" {
  type = string
}
variable "policy" {
  type    = string
  default = ""
}
variable "account_id" {
  type = string
}
variable "tags" {
  type = map(any)
}
variable "use_regional_naming_convention" {
  type    = bool
  default = true
}