variable "name" {
  description = "Base name used for resources created by this pattern."
  type        = string
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC."
  type        = string
}

variable "azs" {
  description = "List of availability zones to use."
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets (one per AZ)."
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets (one per AZ)."
  type        = list(string)
}

variable "allowed_ingress_cidr_blocks" {
  description = "CIDR blocks allowed to ingress to the default app security group."
  type        = list(string)
  default     = []
}

variable "app_ingress_ports" {
  description = "TCP ports allowed for ingress to the default app security group."
  type        = list(number)
  default     = [443]
}

variable "tags" {
  description = "Base tags applied to all resources."
  type        = map(string)
  default     = {}
}
