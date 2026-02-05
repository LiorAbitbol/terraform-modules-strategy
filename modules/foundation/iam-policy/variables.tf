variable "name" {
  description = "Name of the IAM policy."
  type        = string
}

variable "description" {
  description = "Description of the IAM policy."
  type        = string
  default     = "Managed by Terraform"
}

variable "policy" {
  description = "JSON policy document for the IAM policy."
  type        = string
}

variable "tags" {
  description = "Additional tags to apply to all resources."
  type        = map(string)
  default     = {}
}
