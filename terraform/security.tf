// file: security.tf

resource "aws_cloudfront_origin_access_identity" "oai" {
  comment = "OAI for ${var.bucket_name} static site"
}

resource "aws_s3_bucket_policy" "static_site_policy" {
  bucket = aws_s3_bucket.static_site.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = aws_cloudfront_origin_access_identity.oai.iam_arn
        }
        Action   = ["s3:GetObject"]
        Resource = "${aws_s3_bucket.static_site.arn}/*"
      },
      {
        Effect    = "Deny"
        Principal = "*"
        Action    = ["s3:GetObject"]
        Resource  = "${aws_s3_bucket.static_site.arn}/*"
        Condition = {
          Bool = {
            "aws:SecureTransport" = "false"
          }
        }
      }
    ]
  })
}

output "oai_id" {
  value = aws_cloudfront_origin_access_identity.oai.id
}

output "oai_iam_arn" {
  value = aws_cloudfront_origin_access_identity.oai.iam_arn
}
