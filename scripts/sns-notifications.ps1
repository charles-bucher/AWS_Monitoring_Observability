# sns-notifications.ps1
# PowerShell script to create SNS topic and subscribe Charles Bucher's email for alarm notifications

# AWS region and SNS topic details
$region = "us-east-2"
$topicName = "NotifyMe-EC2GIT"
$email = "buchercharles2@gmail.com"

Write-Host "Creating SNS topic '$topicName' in region $region..." -ForegroundColor Cyan

# Create SNS Topic
$createTopicResponse = aws sns create-topic --name $topicName --region $region | ConvertFrom-Json
$topicArn = $createTopicResponse.TopicArn

if ($topicArn) {
    Write-Host "SNS topic created: $topicArn" -ForegroundColor Green
} else {
    Write-Host "Failed to create SNS topic." -ForegroundColor Red
    exit 1
}

# Subscribe your email to the SNS topic
Write-Host "Subscribing email $email to topic..."
$subscribeResponse = aws sns subscribe --topic-arn $topicArn --protocol email --notification-endpoint $email --region $region

if ($subscribeResponse) {
    Write-Host "Subscription request sent. Please check your email ($email) to confirm subscription." -ForegroundColor Yellow
} else {
    Write-Host "Failed to subscribe email to SNS topic." -ForegroundColor Red
    exit 1
}

Write-Host "SNS setup complete. Waiting on email confirmation to receive notifications." -ForegroundColor Green
