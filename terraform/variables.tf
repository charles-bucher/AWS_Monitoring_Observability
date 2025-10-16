###########################
# General / Environment
###########################

variable "environment" {
  description = "Environment tag for resources"
  type        = string
  default     = "dev"
}

variable "aws_region" {
  description = "AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"
}

variable "aws_profile" {
  description = "AWS CLI profile name"
  type        = string
  default     = "default"
}

###########################
# VPC
###########################

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24"]
}

###########################
# EC2
###########################

variable "ami_id" {
  description = "AMI ID for EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "SSH key name for EC2 instance"
  type        = string
}

variable "security_group_id" {
  description = "Security group ID for EC2 instance"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID to launch EC2 instance"
  type        = string
}

###########################
# IAM
###########################

variable "charles_b_username" {
  description = "IAM user name"
  type        = string
  default     = "charles_b"
}

###########################
# S3
###########################

variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}

variable "logging_bucket" {
  description = "S3 bucket for server access logs"
  type        = string
}

###########################
# RDS / Database (Optional)
###########################

variable "db_name" {
  description = "Database name"
  type        = string
  default     = "mydb"
}

variable "db_username" {
  description = "Database username"
  type        = string
  default     = "admin"
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}

variable "db_port" {
  description = "Database port"
  type        = number
  default     = 3306
}
