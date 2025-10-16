###########################
# Security Group for EC2
###########################

resource "aws_security_group" "ec2_sg" {
  name        = "ec2-security-group"
  description = "Allow SSH, HTTP, and HTTPS inbound traffic"
  vpc_id      = var.vpc_id

  ###########################
  # Inbound Rules
  ###########################
  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "HTTPS"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ###########################
  # Outbound Rules
  ###########################
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "EC2-SG"
  }
}

###########################
# Optional: Security Group for RDS
###########################

resource "aws_security_group" "rds_sg" {
  name        = "rds-security-group"
  description = "Allow MySQL/PostgreSQL inbound from EC2"
  vpc_id      = var.vpc_id

  ingress {
    description      = "Allow EC2 access"
    from_port        = var.rds_port   # 3306 for MySQL, 5432 for PostgreSQL
    to_port          = var.rds_port
    protocol         = "tcp"
    security_groups  = [aws_security_group.ec2_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "RDS-SG"
  }
}
