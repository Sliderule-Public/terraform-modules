variable "environment" {
  type = string
}
variable "company_name" {
  type = string
}
variable "security_group_name" {
  type = string
}
variable "region" {
  type    = string
  default = ""
}
variable "vpc_id" {
  type = string
}
variable "ingress_rules" {
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_block  = string
  }))

  default = []
}

variable "ipv6_ingress_rules" {
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_block  = string
  }))

  default = []
}

variable "sg_ingress_rules" {
  type = list(object({
    description     = string
    from_port       = number
    to_port         = number
    protocol        = string
    security_groups = list(string)
  }))

  default = []
}

variable "pl_ingress_rules" {
  type = list(object({
    description     = string
    from_port       = number
    to_port         = number
    protocol        = string
    prefix_list_ids = list(string)
  }))

  default = []
}

variable "egress_rules" {
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_block  = string
  }))
  default = []
}
variable "tags" {
  type = map(any)
}

variable "use_regional_naming_convention" {
  type    = bool
  default = true
}
