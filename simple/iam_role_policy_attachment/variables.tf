variable "role_arn" {
  type = string
}
variable "policy_arn" {
  type = string
}
variable "tags" {
  type = object({
    Company           = string
    Deployment_Method = string
  })
}