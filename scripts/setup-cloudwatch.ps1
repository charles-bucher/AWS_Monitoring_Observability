# setup-cloudwatch.ps1
# PowerShell script to setup CloudWatch monitoring and alarms for Charles Bucher's EC2 instance

# AWS region
$region = "us-east-2"

# EC2 instance and alarm details
$instanceId = "i-01a5e58f7ad1ed8ec"
$alarmName = "HighCPUUtilization-EC2GIT"
$alarmDescription = "Alarm when CPU utilization exceeds 80% on instance $instanceId"
$snsTopicArn = "arn:aws:sns:us-east-2:965638720293:NotifyMe-EC2GIT"

Write-Host "Starting CloudWatch setup for instance $instanceId..." -ForegroundColor Cyan

# Check if SNS topic exists
Write-Host "Verifying SNS topic $snsTopicArn..."
$topics = aws sns list-topics --region $region --output json | ConvertFrom-Json
if ($topics.Topics.TopicArn -contains $snsTopicArn) {
    Write-Host "SNS topic found." -ForegroundColor Green
} else {
    Write-Host "SNS topic NOT found. Please create the SNS topic before proceeding." -ForegroundColor Red
    exit 1
}

# Create CloudWatch alarm
Write-Host "Creating CloudWatch alarm $alarmName..."
aws cloudwatch put-metric-alarm `
    --alarm-name $alarmName `
    --alarm-description $alarmDescription `
    --metric-name CPUUtilization `
    --namespace AWS/EC2 `
    --statistic Average `
    --period 300 `
    --evaluation-periods 1 `
    --threshold 80 `
    --comparison-operator GreaterThanThreshold `
    --dimensions Name=InstanceId,Value=$instanceId `
    --alarm-actions $snsTopicArn `
    --region $region

if ($LASTEXITCODE -eq 0) {
    Write-Host "CloudWatch alarm setup complete and linked to SNS topic." -ForegroundColor Green
} else {
    Write-Host "Failed to create CloudWatch alarm." -ForegroundColor Red
}
