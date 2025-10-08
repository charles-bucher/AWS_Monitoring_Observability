# create-alarms.ps1
# PowerShell script to create CloudWatch alarm for Tommy813's EC2 instance CPU utilization

# Set AWS region and resource identifiers
$region = "us-east-2"
$alarmName = "HighCPUUtilization-EC2GIT"
$alarmDescription = "Alarm when CPU utilization exceeds 80% on EC2 instance i-01a5e58f7ad1ed8ec"
$instanceId = "i-01a5e58f7ad1ed8ec"
$snsTopicArn = "arn:aws:sns:us-east-2:965638720293:NotifyMe-EC2GIT"

Write-Host "🚨 Creating CloudWatch alarm '$alarmName' for EC2 instance $instanceId..." -ForegroundColor Cyan

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
    Write-Host "✅ Alarm created successfully and wired to SNS!" -ForegroundColor Green
} else {
    Write-Host "❌ Alarm creation failed. Check your AWS CLI config and resource permissions." -ForegroundColor Red
}
