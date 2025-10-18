# 📊 Proactive Infrastructure Monitoring with CloudWatch & SNS

**Enterprise-Grade Observability with Automated Alerting and Response**  
*Terraform | AWS Certified | CloudWatch & SNS*

---

## 🎯 Project Overview
This project implements a **production-ready monitoring and alerting system** using AWS CloudWatch, SNS, and Lambda. Not just "set up some alarms" — a **comprehensive observability solution** that detects problems before they impact users.

**Why This Matters:**
- ✅ Real-time visibility into system health  
- ✅ Proactive alerts before failures cascade  
- ✅ Automated response to common incidents  
- ✅ Historical data for capacity planning  
- ✅ SLA tracking and reporting

---

## 🏗️ Architecture

![Architecture Diagram](screenshots/architecture-diagram.png)

**Components:**
- **EC2, RDS, Lambda, ALB** → Monitored via CloudWatch  
- **CloudWatch Metrics** → CPU, Memory, Disk I/O, Network, Application logs, Custom metrics  
- **CloudWatch Alarms** → Threshold, composite, anomaly detection, metric math  
- **SNS Topics** → Critical, Warning, Info messages  
- **Automated Response** → Lambda functions to remediate issues automatically  

![Simulation Result](screenshots/simulation-result.png)

---

## 🔥 Key Features

### 📈 Comprehensive Monitoring
- Built-in AWS metrics for EC2, RDS, Lambda, ELB  
- Custom application metrics via CloudWatch Agent  
- Centralized logs with CloudWatch Logs  
- Real-time dashboards  

### 🚨 Intelligent Alerting
- Threshold-based & composite alarms  
- ML-powered anomaly detection  
- Alert actions → SNS, Lambda, Auto Scaling  

### ⚡ Automated Response
- Lambda-powered remediation  
- Auto Scaling integration  
- Automatic ticket creation & escalation workflows  
- Self-healing infrastructure  

### 📊 Operational Insights
- 15 months metric history for trends & capacity planning  
- SLA tracking & uptime reports  
- Cost visibility & compliance auditing  

---

## 📋 Technical Implementation

**Tech Stack:**
- AWS CloudWatch (metrics, alarms, dashboards, logs)  
- AWS SNS (notification routing)  
- AWS Lambda (automated responses)  
- AWS EventBridge (event-driven automation)  
- Terraform (IaC)  
- Python (Lambda functions)  
- CloudWatch Agent (custom metrics)

**Sample Critical Alarms (YAML):**
```yaml
EC2_High_CPU:
  metric: CPUUtilization
  threshold: "> 90% for 2 consecutive periods (10 mins)"
  action: SNS → Lambda → Scale Up
