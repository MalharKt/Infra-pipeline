resource "aws_eks_access_entry" "bastion" {
  cluster_name  = var.cluster_name
  principal_arn = var.bastion_role_arn
  type          = "STANDARD"

  depends_on = [
    aws_eks_cluster.this
  ]

  tags = {
    Name = "bastion-access-entry"
  }
}
