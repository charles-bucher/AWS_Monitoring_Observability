###########################
# Main Terraform File
###########################

# Optional: high-level orchestration can go here
# Since resources are in separate files, you don't need to redeclare them here.

# Example: you could call modules in the future
# module "vpc" {
#   source     = "./modules/vpc"
#   cidr_block = var.vpc_cidr
# }

# module "ec2" {
#   source        = "./modules/ec2"
#   subnet_id     = module.vpc.public_subnet_id
#   instance_type = var.instance_type
# }

# Right now, leave this file empty to avoid duplicates
