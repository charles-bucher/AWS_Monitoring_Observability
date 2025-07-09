📊 AWS Monitoring Support Lab
Built & Owned by Charles — Aspiring Cloud Engineer

🧠 Project Overview
This project walks through building a full AWS monitoring and alerting setup using EC2, S3, CloudWatch, SNS, and IAM. It’s designed to collect metrics, trigger alarms, and send real-time notifications so I can keep my infrastructure healthy and ready to scale.

It showcases automated metrics collection, real-time alarms, and notifications to keep systems healthy and available.

⚙️ Architecture Diagram
lua
Copy code
      +-------------------+        Metrics         +-------------------------+         Alerts        +--------------------+
      |                   | ---------------------> |                         | --------------------> |                    |
      |    EC2 Instance    |                        |    CloudWatch Alarms &   |                      |      SNS Topic      |
      |  (App & Metrics)   | <--------------------- |       CloudWatch Logs    | <-------------------- |  (Email Notifs)     |
      +-------------------+         Logs            +-------------------------+                       +--------------------+
              |
              |
              v
       +-------------------+
       |                   |
       |     S3 Bucket     |
       |  (Logs Archive)   |
       +-------------------+
Diagram Explanation
EC2 Instance runs the app and sends metrics & logs.

CloudWatch monitors metrics, triggers alarms, and stores logs.

SNS Topic sends notifications instantly when alarms fire.

S3 Bucket archives logs for audit and compliance.

📦 Components Breakdown
Service	Role
EC2	Runs the application and sends metrics/logs
CloudWatch	Collects metrics, creates alarms & dashboards
SNS	Sends notifications for alarm alerts
S3	Centralized logs storage for retention and analysis
IAM	Securely controls access and permissions

🚀 Features
Custom alarms on CPU, disk I/O, network metrics

Real-time SNS email alerts on alarm triggers

Logs aggregated and stored securely in S3

IAM roles applying least privilege principle

Scripts for easy deployment and management

🧪 How to Use
Launch EC2 instance(s) with CloudWatch agent installed

Configure CloudWatch agent to send metrics and logs

Deploy CloudWatch alarms using provided scripts/configs

Subscribe your email to SNS topics for notifications

Monitor via CloudWatch dashboards and respond promptly

🔐 Security Considerations
IAM roles strictly limit permissions

S3 bucket policies restrict access tightly

SNS communication encrypted and secured

Alarm thresholds carefully tuned to reduce noise

🧩 Folder Structure
bash
Copy code
.
├── configs/      # CloudWatch alarm and log configs
├── scripts/      # Setup, deployment, and cleanup scripts
├── docs/         # Architecture diagrams and documentation
├── logs/         # Sample log files for testing and demo
├── README.md     # Project overview and instructions
└── LICENSE       # MIT License info
📈 Monitoring & Alerts Demo
Add your own screenshots or animated GIFs here:

CloudWatch alarms dashboard snapshot

Example SNS email alert

Logs preview in S3 bucket

📚 References
AWS CloudWatch Docs

AWS SNS Docs

IAM Best Practices

S3 Bucket Policies

🎯 Why This Matters
Building this lab sharpened my hands-on skills with AWS monitoring — a critical step toward managing reliable, scalable cloud systems. Keeping my infrastructure healthy means fewer surprises and more uptime, exactly what any cloud engineer should aim for.
