output "cluster_role_arn" {
  value = aws_iam_role.eks_cluster.arn
}

output "node_role_arn" {
  value = aws_iam_role.eks_node.arn
}

output "bastion_instance_profile" {
  value = aws_iam_instance_profile.bastion.name
}
