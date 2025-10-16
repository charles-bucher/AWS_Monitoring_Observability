###########################
# EC2 Outputs
###########################

output "ec2_instance_id" {
  value       = aws_instance.web_server.id
  description = "ID of the EC2 instance"
}

output "ec2_public_ip" {
  value       = aws_instance.web_server.public_ip
  description = "Public IP of the EC2 instance"
}

###########################
# CloudWatch IAM Role Output
###########################

output "cloudwatch_role_arn" {
  value       = aws_iam_role.cloudwatch_role.arn
  description = "ARN of the CloudWatch IAM role"
}

###########################
# IAM User Output
###########################

output "charles_b_user_name" {
  value       = aws_iam_user.charles_b.name
  description = "Name of IAM user charles_b"
}

###########################
# S3 Bucket Output
###########################

output "s3_bucket_name" {
  value       = aws_s3_bucket.my_bucket.bucket
  description = "Name of the S3 bucket"
}

###########################
# VPC Outputs
###########################

output "vpc_id" {
  value       = aws_vpc.main.id
  description = "ID of the VPC"
}

output "public_subnet_ids" {
  value       = aws_subnet.public[*].id
  description = "List of public subnet IDs"
}

output "private_subnet_ids" {
  value       = aws_subnet.private[*].id
  description = "List of private subnet IDs"
}
