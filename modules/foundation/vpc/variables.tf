variable "name" {
  description = "Base name used for VPC and related resources."
  type        = string
}

variable "cidr_block" {
  description = "CIDR block for the VPC."
  type        = string
}

variable "azs" {
  description = "List of availablity zones to use."
  type        = list(string)
}

variable "public_subnet_cidr" {
  description = "CIDR blocks for public subnets (one per AZ)."
  type        = list(string)
}

variable "private_subnet_cidr" {
  description = "CIDR blocks for private subnets (one per AZ)."
  type        = list(string)
}

variable "tags" {
  description = "Additional tags to apply to all resources."
  type        = map(string)
  default     = {}
}
