// file: ian.tf (debug-ready)

terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # Optional: S3 backend for remote state
  # backend "s3" {
  #   bucket  = "my-terraform-state-bucket"
  #   key     = "project/s3-cloudfront/terraform.tfstate"
  #   region  = "us-east-1"
  #   encrypt = true
  # }
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile != "" ? var.aws_profile : null
}

############################
# Debug toggle (environmental)
############################
variable "debug" {
  description = "Enable debug logging for modules (true/false)"
  type        = bool
  default     = false
}

############################
# Modules
############################

module "s3_static_site" {
  source = "./modules/s3"

  bucket_name     = var.bucket_name
  index_document  = var.index_document
  error_document  = var.error_document
  force_destroy   = var.force_destroy
  logging_bucket  = var.logging_bucket
  lifecycle_rules = var.lifecycle_rules

  # Optional debug
  enable_debug = var.debug
}

module "acm_cert" {
  source = "./modules/acm"

  domain_name       = var.domain_name
  validation_method = var.validation_method
  hosted_zone_id    = var.hosted_zone_id

  enable_debug = var.debug
}

module "cloudfront" {
  source = "./modules/cloudfront"

  domain_name         = var.domain_name
  acm_certificate_arn = module.acm_cert.certificate_arn
  origin_bucket       = module.s3_static_site.bucket_arn
  index_document      = var.index_document
  error_document      = var.error_document

  default_ttl        = var.cf_default_ttl
  max_ttl            = var.cf_max_ttl
  min_ttl            = var.cf_min_ttl
  price_class        = var.cf_price_class
  enable_compression = var.cf_enable_compression

  enable_debug = var.debug
}

############################
# Outputs
############################

output "cloudfront_url" {
  description = "CloudFront distribution domain name"
  value       = try(module.cloudfront.cloudfront_url, module.cloudfront.domain_name, null)
}

output "s3_bucket_name" {
  description = "S3 static site bucket name"
  value       = try(module.s3_static_site.bucket_name, null)
}

output "acm_certificate_arn" {
  description = "ACM certificate ARN used by CloudFront"
  value       = try(module.acm_cert.certificate_arn, null)
}

############################
# Variables
############################

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "aws_profile" {
  description = "Optional AWS CLI profile name"
  type        = string
  default     = ""
}

variable "domain_name" {
  description = "Root domain or subdomain for the site"
  type        = string
  default     = ""
}

variable "hosted_zone_id" {
  description = "Route53 hosted zone ID for DNS validation"
  type        = string
  default     = ""
}

variable "validation_method" {
  description = "ACM validation method (DNS or EMAIL)"
  type        = string
  default     = "DNS"
}

variable "bucket_name" {
  description = "Name for the S3 bucket"
  type        = string
  default     = "my-static-site-bucket"
}

variable "index_document" {
  description = "Default index document"
  type        = string
  default     = "index.html"
}

variable "error_document" {
  description = "Error document"
  type        = string
  default     = "error.html"
}

variable "force_destroy" {
  description = "Force bucket deletion if not empty"
  type        = bool
  default     = false
}

variable "logging_bucket" {
  description = "Optional S3 bucket for access logs"
  type        = string
  default     = ""
}

variable "lifecycle_rules" {
  description = "Optional S3 lifecycle rules"
  type        = list(any)
  default     = []
}

variable "cf_default_ttl" {
  description = "CloudFront default TTL (seconds)"
  type        = number
  default     = 3600
}

variable "cf_max_ttl" {
  description = "CloudFront max TTL (seconds)"
  type        = number
  default     = 86400
}

variable "cf_min_ttl" {
  description = "CloudFront min TTL (seconds)"
  type        = number
  default     = 0
}

variable "cf_price_class" {
  description = "CloudFront price class (PriceClass_100 / 200 / All)"
  type        = string
  default     = "PriceClass_100"
}

variable "cf_enable_compression" {
  description = "Enable gzip/Brotli compression on CloudFront"
  type        = bool
  default     = true
}
