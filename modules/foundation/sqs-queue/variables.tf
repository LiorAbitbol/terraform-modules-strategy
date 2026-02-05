variable "name" {
  description = "Name of the SQS queue."
  type        = string
}

variable "visibility_timeout_seconds" {
  description = "Visibility timeout for messages in seconds (0-43200)."
  type        = number
  default     = 30
}

variable "message_retention_seconds" {
  description = "Number of seconds to retain messages (60-1209600)."
  type        = number
  default     = 345600
}

variable "max_receive_count" {
  description = "Maximum number of receives before moving to DLQ. Set to 0 to disable DLQ."
  type        = number
  default     = 3
}

variable "dead_letter_queue_name" {
  description = "Name for the dead letter queue. If not provided, DLQ will not be created."
  type        = string
  default     = null
}

variable "delay_seconds" {
  description = "Delay in seconds before messages become available (0-900)."
  type        = number
  default     = 0
}

variable "receive_wait_time_seconds" {
  description = "Long polling wait time in seconds (0-20)."
  type        = number
  default     = 0
}

variable "fifo_queue" {
  description = "Whether this is a FIFO queue (first-in-first-out delivery)."
  type        = bool
  default     = false
}

variable "content_based_deduplication" {
  description = "Enable content-based deduplication for FIFO queues."
  type        = bool
  default     = false
}

variable "kms_key_id" {
  description = "ARN of the KMS key for encrypting messages. If not provided, SQS managed encryption is used."
  type        = string
  default     = null
}

variable "kms_data_key_reuse_period_seconds" {
  description = "Time in seconds for KMS data key reuse (60-86400)."
  type        = number
  default     = 300
}

variable "tags" {
  description = "Additional tags to apply to all resources."
  type        = map(string)
  default     = {}
}
