output "sns_topic_arn" {
  description = "ARN of the SNS topic."
  value       = module.sns_topic.topic_arn
}

output "sns_topic_name" {
  description = "Name of the SNS topic."
  value       = module.sns_topic.topic_name
}

output "sqs_queue_url" {
  description = "URL of the SQS queue."
  value       = module.sqs_queue.queue_url
}

output "sqs_queue_arn" {
  description = "ARN of the SQS queue."
  value       = module.sqs_queue.queue_arn
}

output "sqs_queue_name" {
  description = "Name of the SQS queue."
  value       = module.sqs_queue.queue_name
}

output "dlq_url" {
  description = "URL of the dead letter queue."
  value       = module.sqs_queue.dlq_url
}

output "dlq_arn" {
  description = "ARN of the dead letter queue."
  value       = module.sqs_queue.dlq_arn
}

output "subscription_policy_arn" {
  description = "ARN of the IAM policy for SQS subscription."
  value       = module.sqs_subscription_policy.policy_arn
}
