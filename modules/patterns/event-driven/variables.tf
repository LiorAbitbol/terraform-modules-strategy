variable "name" {
  description = "Base name used for resources created by this pattern."
  type        = string
}

variable "fifo_enabled" {
  description = "Whether to use FIFO (first-in-first-out) queues and topics."
  type        = bool
  default     = false
}

variable "max_receive_count" {
  description = "Maximum number of receives before moving message to DLQ."
  type        = number
  default     = 3
}

variable "visibility_timeout_seconds" {
  description = "Visibility timeout for SQS messages in seconds."
  type        = number
  default     = 30
}

variable "kms_key_id" {
  description = "KMS key ID for encrypting messages. If not provided, AWS managed encryption is used."
  type        = string
  default     = null
}

variable "tags" {
  description = "Base tags applied to all resources."
  type        = map(string)
  default     = {}
}
