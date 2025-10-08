# test-cloudwatch.ps1
# PowerShell script to verify CloudWatch alarm and SNS setup for Charles Bucher's EC2 instance

# Config
$region = "us-east-2"
$alarmName = "HighCPUUtilization-EC2GIT"
$snsTopicName = "NotifyMe-EC2GIT"

Write-Host "Starting CloudWatch and SNS verification..." -ForegroundColor Cyan

# Check CloudWatch Alarm existence
Write-Host "Checking for CloudWatch alarm '$alarmName'..."
$alarms = aws cloudwatch describe-alarms --region $region --alarm-names $alarmName --output json | ConvertFrom-Json

if ($alarms.MetricAlarms.Count -eq 0) {
    Write-Host "Alarm '$alarmName' NOT found." -ForegroundColor Red
} else {
    Write-Host "Alarm '$alarmName' exists." -ForegroundColor Green
    $alarm = $alarms.MetricAlarms[0]
    Write-Host "Alarm Details:"
    Write-Host "  State: $($alarm.StateValue)"
    Write-Host "  Threshold: $($alarm.Threshold)"
    Write-Host "  Actions: $($alarm.AlarmActions -join ', ')"
}

# Get SNS Topic ARN
Write-Host "Fetching SNS topic ARN for '$snsTopicName'..."
$topics = aws sns list-topics --region $region --output json | ConvertFrom-Json
$topicArn = $topics.Topics | Where-Object { $_.TopicArn -like "*$snsTopicName" } | Select-Object -ExpandProperty TopicArn

if (-not $topicArn) {
    Write-Host "SNS topic '$snsTopicName' NOT found." -ForegroundColor Red
} else {
    Write-Host "SNS topic found: $topicArn" -ForegroundColor Green

    # List SNS subscriptions
    Write-Host "Listing subscriptions for SNS topic..."
    $subs = aws sns list-subscriptions-by-topic --topic-arn $topicArn --region $region --output json | ConvertFrom-Json

    if ($subs.Subscriptions.Count -eq 0) {
        Write-Host "No subscriptions found for topic." -ForegroundColor Yellow
    } else {
        Write-Host "Subscriptions:"
        foreach ($sub in $subs.Subscriptions) {
            Write-Host "  Protocol: $($sub.Protocol), Endpoint: $($sub.Endpoint), SubscriptionArn: $($sub.SubscriptionArn)"
        }
    }
}

Write-Host "CloudWatch and SNS verification complete." -ForegroundColor Cyan
