resource "aws_sns_topic" "alarm_topic" {
  name = var.sns_topic_name
}

resource "aws_sns_topic_subscription" "email_subscription" {
  topic_arn = aws_sns_topic.alarm_topic.arn
  protocol  = "email"
  endpoint  = var.sns_email_endpoint
}

output "sns_topic_arn" {
  value = aws_sns_topic.alarm_topic.arn
}
