Proactive Monitoring with AWS CloudWatch & SNS






Table of Contents

Project Overview

Motivation

Architecture

Features

Prerequisites

Setup & Deployment

Clone & config

IAM / permissions

Infrastructure provisioning (Terraform / CloudFormation)

Validation & testing

Usage

Monitoring / Logging Insights

Security Considerations

Cost Implications

Troubleshooting / FAQ

Roadmap / Future Enhancements

Contributing

License

Contact

Project Overview

This project is a hands-on lab for building a proactive monitoring & alerting system on AWS using CloudWatch, SNS, and EC2. It demonstrates how to gather detailed metrics, set alarms, send notifications, and analyze logs so that system issues are caught early, before they escalate.

Motivation

Many systems wait until things break before acting. That causes downtime, user complaints, avoidable incident costs.

This lab aims to shift you to a proactive stance — monitor early signals, notify early, remediate quickly.

Helps you build infrastructure that is maintainable, observable, and resilient.

Architecture
  +--------------------------+        +------------------+         +----------------+
  |                          | ------>|                  |-------->|                |
  |     EC2 Instances        |        |   CloudWatch     |         |      SNS       |
  |  (with detailed metrics) | <--→   |  Alarms / Logs   |         | Notifications  |
  |                          |        |                  |         | (email, SMS,   |
  +--------------------------+        +------------------+         +----------------+


EC2 instances collect metrics (CPU, memory, disk, etc.)

CloudWatch configured to gather both basic + detailed monitoring / custom metrics

Alarms are set for thresholds (eg high CPU, low disk)

SNS topics to send notifications via email, SMS, or other endpoints

Logging via CloudWatch Logs for deeper analysis

Features

✅ Detailed EC2 metrics (CPU, Memory, Disk, etc.)

✅ Configurable thresholds & alarms

✅ SNS notifications when thresholds are crossed

✅ Use of infrastructure as code (IaC) — Terraform / CloudFormation

✅ IAM roles / least privilege

✅ Log collection & potential log alerting

✅ Documentation + tests (if available)

Prerequisites

Before you begin, make sure you have:

An AWS account with permissions to create / manage: EC2, IAM, CloudWatch, SNS, CloudWatch Logs

AWS CLI installed & configured (or credentials via environment / IAM role)

Terraform (if using Terraform configs) or CloudFormation skills if using stacks

Basic familiarity with AWS metrics / monitoring concepts

Setup & Deployment

Follow these steps to get the lab running:

Clone the repo

git clone https://github.com/Tommy813-lab/Proactive-monitoring-with-cloudwatch-sns.git  
cd Proactive-monitoring-with-cloudwatch-sns


Configure AWS credentials

Set up ~/.aws/credentials or use environment variables (AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY)

(Optional) Use aws sts get-caller-identity to verify correct account / role

Choose IaC method / deploy infrastructure

If Terraform: go into the terraform/ or similar folder, update variables, run:

terraform init  
terraform plan  
terraform apply


If CloudFormation: use AWS Console or CLI to deploy stacks.

Set up alarms & SNS topics

Define metric thresholds (e.g. CPU > 80% for 5 min)

Create SNS topics & subscribe endpoints (email, Slack, etc.)

Verify everything works

Trigger a test alarm (e.g. stress CPU or simulate log event)

Check you receive a notification

Check CloudWatch Logs for log entries

Usage

Monitor your AWS environment continuously

Use as a template for adding more alarms / logs (e.g. network, RDS, etc.)

Hook up more SNS subscribers — maybe Slack, Opsgenie, SMS etc.

Use dashboards in CloudWatch to view aggregated alerts & metrics

Monitoring / Logging Insights

CloudWatch Logs can be used for post-mortem & trend analysis

Alarms should be tuned to avoid noise / false positives

Use detailed monitoring (1-minute granularity) where high fidelity is required

Keep retention policies in mind to manage costs

Security Considerations

IAM permissions configured with least privilege

SNS topics encrypted (if sensitive data)

Secure handling of credentials (don’t commit secrets)

Limit who can alter alarms / topics / metrics

Ensure network security (security groups, VPCs) for instances

Cost Implications

CloudWatch detailed metrics cost more (especially 1-minute metrics)

SNS has small costs, especially for SMS or certain regions

IAM / logging storage costs add up — monitor usage

Always set budget / billing alarms in AWS to catch cost surprises

Troubleshooting / FAQ
Problem	Possible Cause	Solution
No notifications coming	SNS subscription not confirmed; alarm not in "ALARM" state	Confirm SNS subscription; force a test or trigger an alarm
Metrics missing (e.g. memory usage)	EC2 lacking the CloudWatch agent; custom metrics not set up	Install CloudWatch agent; ensure permissions & config
Too many alerts	Thresholds too low or interval too short; noisy metrics	Raise threshold; increase evaluation period; use anomaly detection
High costs	Excess detailed metrics; long log retention; many SNS messages	Reduce metric granularity; lower retention; filter logs; limit endpoints
Roadmap / Future Enhancements

🔧 Add dashboards (CloudWatch Dashboards)

🚨 Add anomaly detection & composite alarms

🔒 Add support for multiple environments (dev / staging / prod)

📊 Add metrics for RDS, Lambda, or other AWS services

📱 Add mobile / Slack integration for notifications

🧪 Automatic remediation (lambda invocations when alarm triggers)

Contributing

I welcome contributions! Here’s how you can help:

Open issues for bugs or enhancements

Send pull requests — please include tests or careful manual verification

Follow code style, documentation, and security best practices

Check out [CONTRIBUTING.md] for guidelines.

License

This project is licensed under the MIT License — see [LICENSE.md] for details.

Contact

Charles: Tommy813-lab
Email: Quietopscb@gmail.com
GitHub: Tommy813-lab
