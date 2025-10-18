🚨 proactive-monitoring-with-cloudwatch-sns

TL;DR: Real-world AWS lab for proactive EC2 monitoring using CloudWatch + SNS. Detect CPU/memory/disk pressure before users complain. Designed for Cloud Support Engineers and aspiring SREs. Instant alerts, visual dashboards, and automation-ready CLI workflows.

┌─────────────────┐
│ EC2 Instance    │
│ (Web/API)       │
│                 │
│  [CW Agent]     │  ← Collects: CPU, Memory, Disk
└────────┬────────┘
         │
         │  Pushes metrics every 60s
         ▼
┌─────────────────────────┐
│  Amazon CloudWatch      │
│  - Custom Metrics       │
│  - Standard Metrics     │
│  - Alarms (Thresholds)  │
└────────┬────────────────┘
         │
         │  Alarm State: OK → ALARM
         ▼
┌─────────────────────────┐
│  Amazon SNS Topic       │
│  "Production-Alerts"    │
└────────┬────────────────┘
         │
    ┌────┴────┬──────────┬──────────┐
    ▼         ▼          ▼          ▼
  📧 Email  📱 SMS    💬 Slack  📟 PagerDuty

On-Call Engineer gets notified in < 30 seconds

📘 Scenario
You're a Tier 2 Cloud Support Engineer at a fast-growing SaaS company. The backend EC2 instances are starting to show occasional CPU spikes and disk pressure during business hours.
Your task:

🛑 Detect performance issues before they become incidents
🔔 Alert the on-call engineer via SNS the moment thresholds are breached
📊 Build dashboards for the DevOps team to track trends and resolve root causes

This repo is your weaponized response. ⚔️

🧱 Architecture Overview
┌────────────┐
│    EC2     │
│  (App/API) │
└────┬───────┘
     │
     │  CloudWatch Agent
     │
┌─────────▼─────────┐
│ Amazon CloudWatch │
│ (Metrics & Alarms)│
└─────────┬─────────┘
          │
          │  Alarm Triggered
          ▼
┌────────────────────┐
│  Amazon SNS Topic  │
│ (Email / SMS alert)│
└────────┬───────────┘
         ▼
  On-Call Engineer
  (Phone buzzes instantly)

⚙️ What's Inside
FeatureDescriptionEC2 SetupLaunch an EC2 instance to monitorCloudWatch Agent ConfigCollect memory, disk, CPU metricsCustom MetricsGo beyond default—track disk space, memoryCloudWatch AlarmsDefine thresholds to trigger proactive alertsSNS NotificationSend alerts to on-call engineer (SMS/email)Dashboard SetupVisualize system health trends like a boss

🚀 How to Deploy
1. 🖥️ Launch EC2 + Install CloudWatch Agent
bashsudo yum update -y
sudo yum install -y amazon-cloudwatch-agent
Copy in your cloudwatch-agent-config.json, then start the agent:
bashsudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl \
  -a fetch-config -m ec2 -c file:cloudwatch-agent-config.json -s
2. 📊 Create Alarms
Example: High CPU (over 80% for 5 minutes)
bashaws cloudwatch put-metric-alarm \
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
3. 📬 Set Up SNS Notifications
bashaws sns create-topic --name MySNSTopic

aws sns subscribe \
  --topic-arn arn:aws:sns:us-east-1:123456789012:MySNSTopic \
  --protocol email \
  --notification-endpoint your.email@example.com

📸 Screenshots
IAM Permissions Verification
Checking Terraform user permissions before deployment:
Show Image
Terraform Infrastructure Initialization
Initializing Terraform modules for automated infrastructure deployment:
Show Image

✅ Success Criteria

✅ You get notified within seconds of a high CPU event
✅ Alarm shows up in CloudWatch console
✅ You can track metrics visually via dashboard
✅ App remains up and healthy—users never know there was a problem 😎


🧠 Real-World Use Cases

Monitor high CPU, memory, disk usage on EC2
Alert DevOps before users complain
Track performance during app deployments
Use as template for multi-tier monitoring systems


🧰 Tools Used

Amazon EC2
CloudWatch Agent
CloudWatch Alarms
Amazon SNS
AWS CLI
IAM Role with CloudWatchAgentServerPolicy
Terraform (for Infrastructure as Code)


📚 Skills Demonstrated

CloudWatch metric collection & alerting
SNS setup for real-time alerts
Linux EC2 configuration
Troubleshooting under pressure
Automation-ready CLI workflows
Infrastructure as Code (IaC) with Terraform
IAM permissions management


🗂️ Repository Structure
Proactive-monitoring-with-cloudwatch-sns/
├── README.md
├── screenshots/
│   ├── iam-permissions-check.png
│   └── terraform-init.png
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
Charles – Cloud Support Engineer-in-training 🧑‍💻
Obsessed with cloud health, alerting early, and building quiet, resilient infrastructure.
GitHub: Tommy813-lab

🎓 Certification Alignment
This project aligns with:

AWS Cloud Practitioner
AWS Solutions Architect Associate
AWS SysOps Administrator
AWS DevOps Engineer Professional


📝 License
This project is open source and available for educational purposes.

🤝 Contributing
Contributions, issues, and feature requests are welcome!

⭐ Star this repo if you found it helpful!