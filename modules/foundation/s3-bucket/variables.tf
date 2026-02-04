variable "name" {
  description = "Name of the S3 bucket. Must be globally unique."
  type        = string
}

variable "versioning" {
  description = "Enable versioning for the bucket."
  type        = bool
  default     = false
}

variable "encryption_enabled" {
  description = "Enable server-side encryption for the bucket."
  type        = bool
  default     = true
}

variable "kms_key_id" {
  description = "KMS key ID for encryption. If not provided, AWS managed encryption (AES256) is used."
  type        = string
  default     = null
}

variable "lifecycle_rules" {
  description = <<EOT
List of lifecycle rules for the bucket.

Each rule supports:
- id: unique identifier for the rule
- enabled: whether the rule is enabled
- prefix: object key prefix filter (optional)
- expiration_days: number of days until objects expire (optional)
- transition_days: number of days until transition (optional)
- transition_storage_class: storage class to transition to (optional)
EOT
  type = list(object({
    id                       = string
    enabled                  = bool
    prefix                   = optional(string, null)
    expiration_days          = optional(number, null)
    transition_days          = optional(number, null)
    transition_storage_class = optional(string, null)
  }))
  default = []
}

variable "block_public_acls" {
  description = "Block public ACLs on the bucket."
  type        = bool
  default     = true
}

variable "block_public_policy" {
  description = "Block public bucket policies."
  type        = bool
  default     = true
}

variable "ignore_public_acls" {
  description = "Ignore public ACLs on the bucket."
  type        = bool
  default     = true
}

variable "restrict_public_buckets" {
  description = "Restrict public bucket policies."
  type        = bool
  default     = true
}

variable "logging_enabled" {
  description = "Enable access logging for the bucket."
  type        = bool
  default     = false
}

variable "logging_target_bucket" {
  description = "Target bucket for access logs. Required if logging_enabled is true."
  type        = string
  default     = null
}

variable "logging_target_prefix" {
  description = "Prefix for access log object keys."
  type        = string
  default     = "logs/"
}

variable "tags" {
  description = "Additional tags to apply to all resources."
  type        = map(string)
  default     = {}
}
