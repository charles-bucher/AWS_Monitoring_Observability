AWS Monitoring Support Lab
Built & Documented by Charles Bucher — Aspiring Cloud Engineer

🧠 Overview
This lab is my hands-on playground to set up rock-solid AWS monitoring using CloudWatch, SNS, and EC2. It’s all about building reliable alarms and notifications so I can keep my cloud infrastructure healthy and responsive.

🚀 Features
Monitor CPU, memory, and disk on EC2 instances with CloudWatch Alarms

Get instant alerts with SNS Notifications straight to my inbox

Use detailed monitoring for fine-tuned metrics

Automate deployment with config files: JSON, CloudFormation, Terraform

Follow AWS security best practices — least privilege IAM roles & encrypted topics

🖼️ Architecture Diagram
lua
Copy code
+--------------+          +----------------+          +--------------+
|              |          |                |          |              |
|   EC2        +--------->+  CloudWatch    +--------->+     SNS      |
|  Instances   | Metrics  |  Alarms & Logs | Alerts   |  Topics      |
|              |          |                |          |              |
+--------------+          +----------------+          +--------------+
⚙️ Prerequisites
AWS account with permissions to create CloudWatch, SNS, EC2 resources

AWS CLI installed and configured

Ability to deploy CloudFormation stacks or Terraform configs

🛠️ Setup Instructions
Clone my repo:

bash
Copy code
git clone https://github.com/Tommy813-lab/aws-monitoring-support-lab.git
cd aws-monitoring-support-lab
Configure AWS credentials:
Make sure your AWS keys are set up in ~/.aws/credentials or environment variables.

Deploy the monitoring stack:
Use the CloudFormation or Terraform scripts inside /infrastructure to spin up alarms, SNS topics, and roles.

Verify:
Check the CloudWatch dashboard for your alarms and confirm SNS notifications arrive at your email.

📬 Contact Me
Got questions or want to collab? Hit me up:
📧 buchercharles2@gmail.com
💻 GitHub: Tommy813-lab
