region = "us-east-1"

vpc_cidr = "10.0.0.0/16"

azs = ["us-east-1a", "us-east-1b"]

public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.11.0/24", "10.0.12.0/24"]

admin_cidr   = "0.0.0.0/0"
# ssh_key_name = "bastion-key"

bastion_ami = "ami-0b6c6ebed2801a5cb"

tags = {
  Owner = "Malhar"
}
