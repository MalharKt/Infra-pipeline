variable "name" { type = string }
variable "cluster_name" { 
  default = "private-eks-cluster"
  type = string
   }
variable "vpc_id" { type = string }
variable "private_subnet_ids" { type = list(string) }
variable "bastion_role_arn" { type = string }
variable "cluster_role_arn" { type = string }
variable "node_role_arn" { type = string }
variable "bastion_sg_id" { type = string }
variable "tags" {}

variable "instance_types" { 
  type = list(string)
  default = ["t3.micro"]
   }

variable "ami_type" { 
  type = string
  default = "AL2_x86_64" 
  }
variable "disk_size" { 
  type = number
  default = 20
   }
variable "node_desired_capacity" {
   type = number 
   default = 2
    }
variable "node_max_size" {
   type = number
    default = 2
     }
variable "node_min_size" {
   type = number
    default = 2
     }

