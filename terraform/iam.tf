###########################
# IAM Roles
###########################

resource "aws_iam_role" "cloudwatch_role" {
  name = "cloudwatch-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })

  description = "IAM role for EC2 to access CloudWatch and other AWS services"
}

###########################
# IAM Policies
###########################

resource "aws_iam_policy" "cloudwatch_policy" {
  name        = "cloudwatch-policy"
  description = "Policy to allow CloudWatch monitoring access"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "cloudwatch:*",
          "logs:*",
          "sns:Publish"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

###########################
# Attach Policy to Role
###########################

resource "aws_iam_role_policy_attachment" "cloudwatch_attach" {
  role       = aws_iam_role.cloudwatch_role.name
  policy_arn = aws_iam_policy.cloudwatch_policy.arn
}

###########################
# IAM User: charles_b
###########################

resource "aws_iam_user" "charles_b" {
  name = "charles_b"
  path = "/"
}

resource "aws_iam_user_policy_attachment" "charles_b_attach" {
  user       = aws_iam_user.charles_b.name
  policy_arn = aws_iam_policy.cloudwatch_policy.arn
}

###########################
# Outputs
###########################

output "cloudwatch_role_arn" {
  value       = aws_iam_role.cloudwatch_role.arn
  description = "ARN of the CloudWatch IAM role"
}

output "charles_b_user_name" {
  value       = aws_iam_user.charles_b.name
  description = "Name of IAM user charles_b"
}
