# AWS Monitoring Support Lab 🛠️📊

A production-grade lab designed to demonstrate real-time infrastructure monitoring using **Amazon CloudWatch**, **SNS**, and the **CloudWatch Agent**. This project equips engineers with practical tools to detect, respond, and visualize cloud system events for proactive AWS operations.

---

## ✅ Use Case

> Set up intelligent monitoring for EC2 instances with alerting, logging, and dashboarding — all driven by automation.

---

## 🧠 Key Features

- 🔍 **Detailed EC2 Monitoring** with custom metrics
- 🚨 **Alarms + SNS Notifications** for CPU, disk, and memory thresholds
- 📦 **CloudWatch Agent** setup for in-depth metrics & log streaming
- 📈 **Real-Time Dashboards** to visualize performance
- 🧪 **Test Scripts** to validate alarm behavior and config
- 🧰 **Infrastructure-as-Code ready** PowerShell automation

---

## 📂 Repo Structure

```bash
Aws-monitoring-support-lab/
├── config/          # JSON config files for alarms, SNS, agent
├── docs/            # Diagrams, architecture, visuals
├── scripts/         # PowerShell scripts to deploy monitoring
├── tests/           # Validation scripts for alarms/logs
├── push-fresh.ps1   # Helper script to push repo updates
└── README.md        # Project overview
📊 Architecture Overview

Diagram: CloudWatch monitors EC2 → Alarms trigger SNS → Notifications sent via Email/SMS → Logs flow to CloudWatch Logs

🚀 Quick Start
🔧 Prerequisites
AWS Free Tier account

Configured AWS CLI (aws configure)

PowerShell 5.0+ or compatible terminal

⚙️ Setup Monitoring
powershell
Copy
Edit
# Clone the repo
git clone https://github.com/Tommy813-lab/Aws-monitoring-support-lab.git
cd Aws-monitoring-support-lab

# Run the setup script (coming soon)
./scripts/setup-monitoring.ps1
🧾 Configuration
config/ec2-highcpu-alarm-config.json: Sets CloudWatch alarm for CPU > 80%

config/sns-topic-config.json: Creates SNS topic and email subscription

config/cloudwatch-agent-config.json: Custom agent config for detailed metrics and logs

🔔 Example Alarm Use Case
Alarm: EC2 CPU exceeds 80%
Action: Triggers SNS → Sends email alert
Response: Admin receives notification and investigates
Bonus: Logs available via CloudWatch Logs for troubleshooting

🔍 Validation
Run checks to verify:

CloudWatch Agent is active

Metrics are flowing

Alarms are triggering correctly

Logs are present in CloudWatch

🧑‍💻 Author
Charles Bucher
Cloud Support Enthusiast | Automation Builder | AWS Practitioner
GitHub: Tommy813-lab

📜 License
MIT License — open for modification, use, and contribution.

