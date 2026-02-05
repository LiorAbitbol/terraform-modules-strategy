output "key_id" {
  description = "Globally unique identifier for the KMS key."
  value       = aws_kms_key.this.id
}

output "key_arn" {
  description = "ARN of the KMS key."
  value       = aws_kms_key.this.arn
}

output "key_alias_arns" {
  description = "ARNs of the KMS key aliases."
  value       = { for k, v in aws_kms_alias.this : k => v.arn }
}
