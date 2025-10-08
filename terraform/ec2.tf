data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "sample_ec2" {
  ami           = data.aws_ami.amazon_linux_2023.id
  instance_type = var.instance_type
  
  tags = {
    Name    = "monitoring-demo-instance"
    Project = "ProactiveMonitoring"
  }

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y stress
              EOF
}
