variable "name" {
  description = "Name of the security group."
  type        = string
}

variable "description" {
  description = "Description for the security group."
  type        = string
  default     = "Managed by Terraform"
}

variable "vpc_id" {
  description = "VPC ID where the security group will be created."
  type        = string
}

variable "rules" {
  description = <<EOT
List of security group rules.

Each rule supports:
- type: "ingress" or "egress"
- protocol: "tcp", "udp", "-1" (all), etc.
- from_port/to_port: required unless protocol is "-1"
- cidr_block / ipv6_cidr_block / prefix_list_ids / security_groups: optional source/destination
- description: optional
EOT

  type = list(object({
    type            = string
    protocol        = string
    from_port       = number
    to_port         = number
    cidr_blocks     = optional(list(string), [])
    ipv6_cidr_block = optional(list(string), [])
    prefix_list_ids = optional(list(string), [])
    security_groups = optional(list(string), [])
    self            = optional(bool, null)
    description     = optional(string, null)
  }))

  default = []
}

variable "tags" {
  description = "Additional tags to apply to all resources."
  type        = map(string)
  default     = {}
}