# create-alarms.ps1
# PowerShell script to create CloudWatch alarm for Charles Bucher's EC2 instance CPU utilization

# Set your AWS region
$region = "us-east-2"

# Alarm details
$alarmName = "HighCPUUtilization-EC2GIT"
$alarmDescription = "Alarm when CPU utilization exceeds 80% on instance i-01a5e58f7ad1ed8ec"
$instanceId = "i-01a5e58f7ad1ed8ec"
$snsTopicArn = "arn:aws:sns:us-east-2:965638720293:NotifyMe-EC2GIT"

Write-Host "Creating CloudWatch alarm '$alarmName' for EC2 instance $instanceId..." -ForegroundColor Cyan

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
    Write-Host "Alarm created successfully!" -ForegroundColor Green
} else {
    Write-Host "Failed to create alarm." -ForegroundColor Red
}
