// file: outputs.tf

############################
# Core Outputs
############################

output "cloudfront_url" {
  description = "CloudFront distribution domain name (e.g., d1234abcd.cloudfront.net)"
  value       = try(module.cloudfront.cloudfront_url, module.cloudfront.domain_name, null)
}

output "s3_bucket_name" {
  description = "S3 bucket name hosting the static site"
  value       = try(module.s3_static_site.bucket_name, null)
}

output "acm_certificate_arn" {
  description = "ARN of the ACM certificate used by CloudFront"
  value       = try(module.acm_cert.certificate_arn, null)
}

############################
# Optional / Debug Outputs
############################

output "cloudfront_distribution_id" {
  description = "CloudFront Distribution ID"
  value       = try(module.cloudfront.distribution_id, null)
}

output "cloudfront_domain_name" {
  description = "CloudFront domain name for the distribution"
  value       = try(module.cloudfront.domain_name, null)
}

output "s3_bucket_arn" {
  description = "ARN of the S3 bucket"
  value       = try(module.s3_static_site.bucket_arn, null)
}

output "acm_certificate_status" {
  description = "ACM certificate status (PENDING_VALIDATION, ISSUED, etc.)"
  value       = try(module.acm_cert.certificate_status, null)
}

output "debug_info" {
  description = "Optional debug info if debug=true"
  value       = var.debug ? {
    cloudfront_url       = try(module.cloudfront.cloudfront_url, null)
    s3_bucket_name       = try(module.s3_static_site.bucket_name, null)
    acm_certificate_arn  = try(module.acm_cert.certificate_arn, null)
    cloudfront_status    = try(module.cloudfront.status, null)
  } : null
}
