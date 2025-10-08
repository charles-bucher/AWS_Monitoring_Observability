# cleanup.ps1
# Cleanup script for Tommy813's AWS Monitoring Support Lab resources

# Set AWS Region and resource identifiers
$region = "us-east-2"
$alarmNamePrefix = "HighCPUUtilization-EC2GIT"
$snsTopicName = "NotifyMe-EC2GIT"

Write-Host "🧹 Starting cleanup for Tommy813's AWS Monitoring Lab..." -ForegroundColor Cyan

# Delete CloudWatch Alarms with matching prefix
Write-Host "🔍 Searching for CloudWatch alarms with prefix '$alarmNamePrefix'..."
$alarms = aws cloudwatch describe-alarms --region $region `
  --query "MetricAlarms[?starts_with(AlarmName, \`'$alarmNamePrefix\`')].AlarmName" `
  --output text

if (-not $alarms) {
    Write-Host "⚠️ No matching alarms found." -ForegroundColor Yellow
} else {
    foreach ($alarm in $alarms) {
        Write-Host "❌ Deleting alarm: $alarm"
        aws cloudwatch delete-alarms --region $region --alarm-names $alarm
    }
}

# Find and delete SNS topic
Write-Host "🔎 Looking up SNS topic '$snsTopicName'..."
$topicArn = aws sns list-topics --region $region `
  --query "Topics[?ends_with(TopicArn, '$snsTopicName')].TopicArn" `
  --output text

if (-not $topicArn) {
    Write-Host "⚠️ SNS topic '$snsTopicName' not found." -ForegroundColor Yellow
} else {
    Write-Host "❌ Deleting SNS topic: $topicArn"
    aws sns delete-topic --region $region --topic-arn $topicArn
}

Write-Host "✅ Tommy813's AWS Monitoring Lab cleanup complete!" -ForegroundColor Green
