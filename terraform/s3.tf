###########################
# S3 Bucket
###########################

resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket_name
  acl    = "private"

  tags = {
    Name        = var.bucket_name
    Environment = var.environment
  }
}

###########################
# Enable Versioning
###########################

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.my_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

###########################
# Enable Server Access Logging (Optional)
###########################

resource "aws_s3_bucket_logging" "logging" {
  bucket = aws_s3_bucket.my_bucket.id

  target_bucket = var.logging_bucket      # Must exist
  target_prefix = "${var.bucket_name}/logs/"
}

###########################
# Bucket Policy (Optional Public Access)
###########################
# Uncomment if you need to allow public read (for static website hosting)
# resource "aws_s3_bucket_policy" "public_policy" {
#   bucket = aws_s3_bucket.my_bucket.id
#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Effect = "Allow"
#         Principal = "*"
#         Action = "s3:GetObject"
#         Resource = "${aws_s3_bucket.my_bucket.arn}/*"
#       }
#     ]
#   })
# }
