variable "app_name" {
  type = string
}
variable "company_name" {
  type = string
}
variable "environment" {
  type = string
}
variable "log_group_name" {
  type = string
}
variable "tags" {
  type = object({
    Company           = string
    Deployment_Method = string
  })
}