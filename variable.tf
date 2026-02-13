variable "region" {
  default = "us-east-1"
  type    = string
}

variable "name" {
  type    = string
  default = "eks-vpc-1"
}

variable "cluster_name" {
  type    = string
  default = "private-eks-cluster"
}

variable "vpc_cidr" {
  type = string
}

variable "azs" {
  type = list(string)
}

variable "public_subnet_cidrs" {
  type = list(string)
}

variable "private_subnet_cidrs" {
  type = list(string)
}

variable "admin_cidr" {
  type = string
}

# variable "ssh_key_name" {
#   type = string
# }

variable "bastion_ami" {
  default = "ami-0b6c6ebed2801a5cb"
  type    = string
}

variable "bastion_instance_type" {
  type    = string
  default = "t3.micro"
}

variable "tags" {
  type    = map(string)
  default = {}
}
