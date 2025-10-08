resource "aws_cloudwatch_metric_alarm" "cpu_high" {
  alarm_name          = "cpu-high-alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = 70
  alarm_description   = "Triggered when EC2 CPU utilization exceeds 70%."

  dimensions = {
    InstanceId = aws_instance.sample_ec2.id
  }

  alarm_actions = [
    aws_sns_topic.alarm_topic.arn
  ]

  tags = {
    Project = "ProactiveMonitoring"
  }
}
