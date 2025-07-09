🚨 proactive-monitoring-with-cloudwatch-sns
A real-world AWS lab that shows how to proactively monitor EC2 health using Amazon CloudWatch and send instant alerts via SNS. Designed for Cloud Support Engineers and aspiring SREs, this project helps detect performance degradation before users complain—or worse—before the boss notices. 😅

📘 Scenario
You're a Tier 2 Cloud Support Engineer at a fast-growing SaaS company.
The backend EC2 instances are starting to show occasional CPU spikes and disk pressure during business hours.

Your task:
🛑 Detect performance issues before they become incidents.
🔔 Alert the on-call engineer via SNS the moment thresholds are breached.
📊 Build dashboards for the DevOps team to track trends and resolve root causes.

This repo is your weaponized response. ⚔️

🧱 Architecture Overview
scss
Copy
Edit
             ┌────────────┐
             │   EC2      │
             │ (App/API)  │
             └────┬───────┘
                  │
           CloudWatch Agent
                  │
        ┌─────────▼─────────┐
        │   Amazon CloudWatch │
        │  (Metrics & Alarms) │
        └─────────┬─────────┘
                  │ Alarm Triggered
                  ▼
         ┌────────────────────┐
         │ Amazon SNS Topic   │
         │ (Email / SMS alert)│
         └────────┬───────────┘
                  ▼
           On-Call Engineer
         (Phone buzzes instantly)
⚙️ What’s Inside
Feature	Description
EC2 Setup	Launch an EC2 instance to monitor
CloudWatch Agent Config	Collect memory, disk, CPU metrics
Custom Metrics	Go beyond default—track disk space, memory
CloudWatch Alarms	Define thresholds to trigger proactive alerts
SNS Notification	Send alerts to on-call engineer (SMS/email)
Dashboard Setup	Visualize system health trends like a boss

🚀 How to Deploy
1. 🖥️ Launch EC2 + Install CloudWatch Agent
bash
Copy
Edit
sudo yum update -y
sudo yum install -y amazon-cloudwatch-agent
Copy in your cloudwatch-agent-config.json, then start the agent:

bash
Copy
Edit
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl \
 -a fetch-config -m ec2 -c file:cloudwatch-agent-config.json -s
2. 📊 Create Alarms
Example: High CPU (over 80% for 5 minutes)

bash
Copy
Edit
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
3. 📬 Set Up SNS Notifications
bash
Copy
Edit
aws sns create-topic --name MySNSTopic
aws sns subscribe \
 --topic-arn arn:aws:sns:us-east-1:123456789012:MySNSTopic \
 --protocol email \
 --notification-endpoint your.email@example.com
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

📚 Skills Demonstrated
CloudWatch metric collection & alerting

SNS setup for real-time alerts

Linux EC2 configuration

Troubleshooting under pressure

Automation-ready CLI workflows

💼 About Me
Charles – Cloud Support Engineer-in-training 🧑‍💻
Obsessed with cloud health, alerting early, and building quiet, resilient infrastructure.
GitHub: Tommy813-lab
