output "ids" {
  description = "List of IDs of instances"
  value       = "${module.ec2.id}"
}

output "vpc_security_group_ids" {
  description = "List of VPC security group ids assigned to the instances"
  value       = "${module.ec2.vpc_security_group_ids}"
}

output "vpc_security_subnet_ids" {
  description = "List of VPC subnet ids assigned to the instances"
  value       = "${module.ec2.vpc_subnet_ids}"
}