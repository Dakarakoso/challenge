# Cloud Platform Engineer @ 

![CI Terraform](https://github.com/Dakarakoso/challenge/actions/workflows/terraform.yaml/badge.svg)

## Overview

This repository contains a complete, production-ready AWS infrastructure as code (IaC) for a three-tier CRM application, implemented with Terraform. The goal of this challenge is to demonstrate:

- **Scalable & Secure Architecture** using VPC, NAT gateways, ALB, and WAF
- **Modular IaC**: reusable Terraform modules for networking, security, database, compute, storage, CI/CD, monitoring, backup, and edge delivery
- **Automated CI/CD** via GitHub Actions, building and deploying Dockerized Node.js services to ECS Fargate. Buildspec file for CodeBuild that logs into ECR, builds server & worker images, pushes them, and generates imagedefinitions.json
- **Observability & Alerting** with CloudWatch dashboards and alarms
- **Backup & DR** using AWS Backup with cross-region copy
- **Cost & Security Best Practices** aligned to the AWS Well-Architected framework

---

## Prerequisites

- [Terraform 1.5+](https://www.terraform.io/downloads.html)
- AWS CLI configured with credentials/profile that has IAM, EC2, RDS, S3, ECS, CloudWatch, Backup, CloudFront, Route 53, WAF permissions
- (Optional) [terraform-docs](https://github.com/terraform-docs/terraform-docs) for local module docs

---

## Getting Started

1.  **Clone the repo**

    ```bash
    git clone git@github.com:Dakarakoso/challenge.git
    cd challenge
    ```

2.  **Review Terraform modules**
    Each module in infrastructure/modules/ has its own variables.tf, outputs.tf, and a module README (you can generate/update via terraform-docs).

3.  **Initialize & Plan (prod)**

    ```bash
    cd infrastructure/environments/prod
    terraform init
    terraform plan -out=tfplan
    ```

4.  **Apply**
    ```bash
    terraform apply "tfplan"
    ```

---

## CI/CD

- Workflow: `.github/workflows/terraform.yaml`

- Buildspec: `infrastructure/modules/ci_cd/buildspec.yaml` defines CodeBuild phases:

  - pre_build: log in to ECR
  - build: build Docker images for server & worker
  - post_build: push images to ECR and generate imagedefinitions.json for ECS deploy

- Pipeline Stages: Source (Github) → Build (CodeBuild) → Deploy (ECS)

- Formatting, linting, or validation failures will break the build badge above.

---

## Next steps

- add integration tests
- Automate runbook drills with AWS Systems Manager
