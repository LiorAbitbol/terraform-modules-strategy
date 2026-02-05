variable "name" {
  description = "Display name for the KMS key."
  type        = string
}

variable "description" {
  description = "Description of the KMS key."
  type        = string
  default     = "Managed by Terraform"
}

variable "deletion_window_in_days" {
  description = "Number of days to wait before deleting the key (7-30)."
  type        = number
  default     = 30
}

variable "enable_key_rotation" {
  description = "Enable automatic key rotation."
  type        = bool
  default     = true
}

variable "key_usage" {
  description = "Intended use of the key. Valid values: ENCRYPT_DECRYPT, SIGN_VERIFY."
  type        = string
  default     = "ENCRYPT_DECRYPT"
}

variable "customer_master_key_spec" {
  description = "Specifies whether the key contains a symmetric key or an asymmetric key pair. Valid values: SYMMETRIC_DEFAULT, RSA_2048, RSA_3072, RSA_4096, ECC_NIST_P256, ECC_NIST_P384, ECC_NIST_P521, ECC_SECG_P256K1."
  type        = string
  default     = "SYMMETRIC_DEFAULT"
}

variable "multi_region" {
  description = "Whether the key is a multi-region key."
  type        = bool
  default     = false
}

variable "policy" {
  description = "IAM policy document for the key. If not provided, a default policy will be created that allows the root account to manage the key."
  type        = string
  default     = null
}

variable "aliases" {
  description = "List of aliases to create for the key."
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Additional tags to apply to all resources."
  type        = map(string)
  default     = {}
}
