output "bastion_public_ip" {
  value = aws_instance.bastion.public_ip
}

output "eks_cluster_name" {
  value = module.eks.cluster_name
}

output "bastion_instance_id" {
  value       = aws_instance.bastion.id
  description = "EC2 instance id of the bastion host (SSM managed)"
}

output "bastion_role_arn" {
  value = module.iam.bastion_role_arn
}   