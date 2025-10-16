// file: s3.tf

resource "aws_s3_bucket" "static_site" {
  bucket = var.bucket_name
  acl    = "private"

  force_destroy = var.force_destroy

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  logging {
    target_bucket = var.logging_bucket != "" ? var.logging_bucket : null
    target_prefix = "access-logs/"
  }

  lifecycle_rule {
    id      = "default"
    enabled = true
    prefix  = ""
    transitions = var.lifecycle_rules
  }

  tags = var.tags
}

output "bucket_name" {
  value = aws_s3_bucket.static_site.id
}

output "bucket_arn" {
  value = aws_s3_bucket.static_site.arn
}
