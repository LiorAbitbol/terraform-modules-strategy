variable "name" {
  description = "Name of the SNS topic."
  type        = string
}

variable "display_name" {
  description = "Display name for the SNS topic (for email subscriptions)."
  type        = string
  default     = null
}

variable "kms_key_id" {
  description = "ARN of the KMS key for encrypting messages. If not provided, SNS managed encryption is used."
  type        = string
  default     = null
}

variable "fifo_topic" {
  description = "Whether this is a FIFO topic (first-in-first-out delivery)."
  type        = bool
  default     = false
}

variable "content_based_deduplication" {
  description = "Enable content-based deduplication for FIFO topics."
  type        = bool
  default     = false
}

variable "tags" {
  description = "Additional tags to apply to all resources."
  type        = map(string)
  default     = {}
}
