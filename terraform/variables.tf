variable "region" {
  description = "AWS region to deploy to"
  default     = "us-east-1"
}

variable "ec2_instance_id" {
  description = "EC2 instance ID to monitor"
}

variable "sns_topic_name" {
  description = "SNS topic name"
  default     = "proactive-monitoring-topic"
}

variable "sns_email_endpoint" {
  description = "Email endpoint for SNS notifications"
}
