###########################
# EC2 Instance
###########################

resource "aws_instance" "web_server" {
  ami                         = var.ami_id          # From variables.tf
  instance_type               = var.instance_type   # From variables.tf
  subnet_id                   = var.subnet_id       # From variables.tf
  key_name                    = var.key_name        # From variables.tf
  associate_public_ip_address = true

  # Attach security group
  vpc_security_group_ids = [var.security_group_id]

  # IAM role for instance
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  # Tags
  tags = {
    Name        = "WebServer"
    Environment = var.environment
  }
}

###########################
# IAM Instance Profile
###########################

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2-instance-profile"
  role = aws_iam_role.cloudwatch_role.name
}

###########################
# Optional: Output Instance ID & Public IP
###########################

output "ec2_instance_id" {
  value       = aws_instance.web_server.id
  description = "ID of the EC2 instance"
}

output "ec2_public_ip" {
  value       = aws_instance.web_server.public_ip
  description = "Public IP of the EC2 instance"
}
