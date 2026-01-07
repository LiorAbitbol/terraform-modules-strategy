output "vpc_id" {
  description = "ID of the VPC."
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "IDs of public subnets."
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "IDs of private subnets."
  value       = module.vpc.private_subnet_ids
}

output "app_security_group_id" {
  description = "ID of the default application security group."
  value       = module.app_security_group.security_group_id
}
