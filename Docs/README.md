# 📚 Documentation for CloudWatch-Sentinel

This documentation provides a **deep dive into the architecture, deployment, and modules** used in CloudWatch-Sentinel.

---

## 🏗️ Architecture

- Modular, production-grade cloud resources
- Serverless functions for automation
- Monitoring and alerting dashboards
- Secure S3 + CloudFront static hosting
- CI/CD pipelines for automated validation & deployment

---

## ⚡ Deployment Instructions

1. Clone the repo:
```bash
git clone https://github.com/charles-bucher/CloudWatch-Sentinel.git
cd CloudWatch-Sentinel
```

2. Initialize Terraform:
```bash
terraform init
```

3. Configure environment:
```bash
export AWS_PROFILE=your-profile
export AWS_REGION=us-east-1
```

4. Apply infrastructure:
```bash
terraform apply
```

5. Verify resources:
- Check AWS Console for deployed infrastructure
- Validate CloudWatch dashboards and monitoring alerts
- Test Lambda automations and static site hosting

---

## 🧩 Modules & Scripts

- `modules/` – reusable Terraform modules
- `scripts/` – automation, deployment, testing scripts
- `Terraform/` – environment-specific IaC
- `diagrams/` – architecture visuals
- `screenshots/` – deployment and monitoring examples

---

## 🧠 Learning Outcomes

- Secure multi-tier cloud architecture
- Automation with IaC and serverless functions
- CI/CD pipelines for production deployment
- Monitoring, alerting, and cost management

---

## 📆 Roadmap

- Add automated testing via Terratest
- Multi-region disaster recovery
- Cost optimization automation
- Blog posts and portfolio documentation

---

