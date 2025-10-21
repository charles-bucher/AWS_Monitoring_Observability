terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "my-terraform-state-bucket"
    key            = "infra/${terraform.workspace}/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}

provider "aws" {
  region = var.aws_region
}

# Example: deploy a minimal S3 bucket
resource "aws_s3_bucket" "app_bucket" {
  bucket = "${var.project_name}-${terraform.workspace}-bucket"
  tags = {
    Environment = terraform.workspace
    Project     = var.project_name
    ManagedBy   = "Terraform"
    Author      = "Charles_Bucher"
  }
}
