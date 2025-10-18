🚨 Proactive Monitoring with CloudWatch & SNS

TL;DR: Hands-on AWS lab for proactive EC2 monitoring. Detect CPU, memory, and disk pressure before users notice. Real-time alerts, dashboards, and automation-ready workflows for Cloud Support Engineers and aspiring SREs.

🧠 Purpose & Context

This project simulates a real-world scenario where backend EC2 instances experience performance spikes:

Detect issues before they become incidents

Alert on-call engineers via SNS in <30 seconds

Build dashboards for trend analysis and root-cause resolution

I built this to demonstrate hands-on AWS monitoring, alerting, and infrastructure automation using Terraform.

🧱 Architecture Overview
┌─────────────┐
│ EC2 Instance│  (App/API)
└─────┬───────┘
      │
 CloudWatch Agent
      ▼
┌───────────────┐
│ Amazon CloudWatch │ Metrics & Alarms
└─────┬─────────┘
      ▼
┌───────────────┐
│ Amazon SNS    │ Email / SMS / Slack
└─────┬─────────┘
      ▼
On-Call Engineer Notified < 30s

🖼 Screenshots

IAM Permissions Check:


CloudWatch Agent Config:


Terraform Deployment:


⚙️ What This Project Does

Automatic Metric Collection:

CPU, memory, and disk metrics every 60s via CloudWatch Agent

Alarming & Notifications:

Threshold-based alarms (e.g., CPU > 80% for 5 minutes)

SNS sends instant alerts via Email, SMS, or Slack

Infrastructure Automation:

Terraform modules manage EC2, IAM roles, CloudWatch alarms, and SNS topics

Visual Monitoring:

Dashboards track system health and trends over time

🚀 Deployment Steps

Launch EC2 & install CloudWatch Agent

sudo yum update -y
sudo yum install -y amazon-cloudwatch-agent
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl \
-a fetch-config -m ec2 -c file:cloudwatch-agent-config.json -s


Create CloudWatch Alarms

aws cloudwatch put-metric-alarm \
--alarm-name "HighCPUAlarm" \
--metric-name CPUUtilization \
--namespace AWS/EC2 \
--statistic Average \
--period 300 \
--threshold 80 \
--comparison-operator GreaterThanThreshold \
--evaluation-periods 1 \
--dimensions Name=InstanceId,Value=i-0123456789abcdef0 \
--alarm-actions arn:aws:sns:us-east-1:123456789012:MySNSTopic


Set Up SNS Notifications

aws sns create-topic --name MySNSTopic
aws sns subscribe \
--topic-arn arn:aws:sns:us-east-1:123456789012:MySNSTopic \
--protocol email \
--notification-endpoint your.email@example.com

✅ Success Criteria

Alerts reach on-call engineer within 30 seconds

CloudWatch dashboard visualizes CPU, memory, and disk metrics

Historical trends can be analyzed for root cause

EC2 instances remain stable; users remain unaffected

🧰 Tools Used

Amazon EC2 – Host application/API workloads

CloudWatch Agent – Collect metrics every 60s

CloudWatch Alarms – Threshold-based alerting

Amazon SNS – Instant notifications via Email/SMS/Slack

AWS CLI – Deployment & automation

Terraform – Infrastructure as Code (IaC)

IAM Roles & Policies – Least-privilege security

📚 Skills Demonstrated

CloudWatch metric collection & alerting

Real-time alert delivery with SNS

EC2 instance configuration & monitoring

Troubleshooting under pressure

CLI-based automation workflows

Infrastructure as Code (Terraform) & IAM management

🗂 Repository Structure
Proactive-monitoring-with-cloudwatch-sns/
├── README.md
├── screenshots/
│   ├── iam-permissions-check.png
│   ├── iam-config-screenshot.png
│   └── terraform-deploy-screenshot.png
├── configs/
│   └── cloudwatch-agent-config.json
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   └── outputs.tf
└── scripts/
    ├── setup-cloudwatch.sh
    └── test-cpu-spike.sh

💼 About Me

Charles – Cloud Support Engineer-in-training. Obsessed with cloud health, early alerting, and resilient infrastructure.

GitHub: Tommy813-lab

🎓 Certification Alignment

AWS Cloud Practitioner

AWS Solutions Architect Associate

AWS SysOps Administrator

AWS DevOps Engineer Professional

📝 License

Open-source and available for educational purposes.

🤝 Contributing

Contributions, issues, and feature requests are welcome!
