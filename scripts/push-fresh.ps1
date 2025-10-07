# push-fresh.ps1
# PowerShell script to sync website files to S3 and invalidate CloudFront cache
# Built & Owned by Charles — Aspiring Cloud Engineer

# Configurations
$region = "us-east-1"
$s3Bucket = "my-web-app-ctb"  # Change to your actual S3 bucket name
$cloudFrontDistributionId = "YOUR_CLOUDFRONT_DISTRIBUTION_ID"  # Replace with your CloudFront Distribution ID
$websiteFolder = ".\website"  # Path to your local website files

Write-Host "Starting website deployment..." -ForegroundColor Cyan

# Sync files to S3 bucket
Write-Host "Syncing files from $websiteFolder to s3://$s3Bucket ..."
aws s3 sync $websiteFolder "s3://$s3Bucket" --region $region --delete

if ($LASTEXITCODE -ne 0) {
    Write-Host "Error syncing files to S3 bucket." -ForegroundColor Red
    exit 1
}

Write-Host "S3 sync completed successfully." -ForegroundColor Green

# Invalidate CloudFront cache
Write-Host "Creating CloudFront cache invalidation for distribution $cloudFrontDistributionId ..."
$invalidation = aws cloudfront create-invalidation --distribution-id $cloudFrontDistributionId --paths "/*" --region $region | ConvertFrom-Json

if ($invalidation.Invalidation.Id) {
    Write-Host "Invalidation created successfully with ID: $($invalidation.Invalidation.Id)" -ForegroundColor Green
} else {
    Write-Host "Failed to create CloudFront invalidation." -ForegroundColor Red
    exit 1
}

Write-Host "Website deployment complete. Your site is fresh and live!" -ForegroundColor Cyan
