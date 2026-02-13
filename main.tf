provider "aws" {
  region = var.region
}

module "vpc" {
  source               = "./modules/vpc"
  name                 = var.name
  vpc_cidr             = var.vpc_cidr
  azs                  = var.azs
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  tags                 = var.tags
}

module "iam" {
  source = "./modules/iam"
  name   = var.name
  tags   = var.tags
}

# Bastion Security Group removed
resource "aws_security_group" "bastion_sg" {
  name        = "${var.name}-bastion-sg"
  vpc_id      = module.vpc.vpc_id
  description = "Bastion SG - no public SSH; SSM agent only"

  # NO ingress from Internet. If you want internal admin networks,
  # add specific CIDR(s) or security-group-based rules here.
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [] # intentionally empty
  }

  # allow outbound to reach AWS endpoints (SSM, EKS, S3, etc.)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}

# Bastion EC2
resource "aws_instance" "bastion" {
  ami           = var.bastion_ami
  instance_type = var.bastion_instance_type
  subnet_id     = module.vpc.public_subnets[0]
  #key_name                    = var.ssh_key_name
  vpc_security_group_ids      = [aws_security_group.bastion_sg.id]
  iam_instance_profile        = module.iam.bastion_instance_profile
  associate_public_ip_address = true

  user_data = <<-EOF
    #!/bin/bash
    sudo apt update -y || true
    # install unzip
    sudo apt install unzip -y || true
    # install awscli v2
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o /tmp/awscliv2.zip
    unzip -o /tmp/awscliv2.zip -d /tmp
    /tmp/aws/install || true
    # install kubectl
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" || true
    install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl || true
    mkdir -p /home/ubuntu/.kube
    chown ubuntu:ubuntu /home/ubuntu/.kube || true
  EOF

  tags = merge(var.tags, { Name = "${var.name}-bastion" })
}

module "eks" {
  source             = "./modules/eks"
  name               = var.name
  cluster_name       = var.cluster_name
  bastion_role_arn   = module.iam.bastion_role_arn
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnets
  cluster_role_arn   = module.iam.cluster_role_arn
  node_role_arn      = module.iam.node_role_arn
  bastion_sg_id      = aws_security_group.bastion_sg.id
  tags               = var.tags
}
