output "cloudwatch_alarm_name" {
  value = aws_cloudwatch_metric_alarm.cpu_high.alarm_name
}

output "sns_topic_arn" {
  value = aws_sns_topic.alarm_topic.arn
}
