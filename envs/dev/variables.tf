variable "aws_region" {
  description = "AWS region to deploy into."
  type        = string
  default     = "us-east-1"
}

variable "name" {
  description = "Base name for all resources."
  type        = string
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC."
  type        = string
}

variable "azs" {
  description = "Availability zones to use."
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "Public subnet CIDR blocks."
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "Private subnet CIDR blocks."
  type        = list(string)
}

variable "allowed_ingress_cidr_blocks" {
  description = "CIDR blocks allowed to access the app."
  type        = list(string)
  default     = []
}

variable "app_ingress_ports" {
  description = "Application ingress ports."
  type        = list(number)
  default     = [443]
}

variable "tags" {
  description = "Tags applied to all resources."
  type        = map(string)
  default     = {}
}
