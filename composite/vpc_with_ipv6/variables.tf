variable "vpc_cidr_block" {
  type = string
}
variable "environment" {
  type = string
}
variable "company_name" {
  type = string
}
variable "tags" {
  type = map(any)
}
variable "vpc_name" {
  type = string
}
variable "region" {
  type = string
}
# I hate this. This is a quick workaround to get the module to work with us-east-2 in our timeframe without redoing the subnets in each
# of our existing environments. This should be removed once we have a chance to redo the subnets.
variable "has_three_azs" {
  type    = bool
  default = false
}
variable "public_nacl_ingress_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr        = string
    rule_number = number
  }))

  default = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr        = "0.0.0.0/0"
      rule_number = 10
    }
  ]
}

variable "public_nacl_egress_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr        = string
    rule_number = number
  }))

  default = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr        = "0.0.0.0/0"
      rule_number = 10
    }
  ]
}

variable "ipv6_nacl_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr        = string
    rule_number = number
  }))

  default = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr        = "::/0"
      rule_number = 37
    }
  ]
}

variable "private_nacl_ingress_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr        = string
    rule_number = number
  }))

  default = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr        = "0.0.0.0/0"
      rule_number = 10
    }
  ]
}

variable "private_nacl_egress_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr        = string
    rule_number = number
  }))

  default = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr        = "0.0.0.0/0"
      rule_number = 10
    }
  ]
}

variable "vpx" {
  type = list(object({
    vpx  = string
    cidr = string
  }))

  default = []
}

variable "kms_key_arn" {
  type = string
}
