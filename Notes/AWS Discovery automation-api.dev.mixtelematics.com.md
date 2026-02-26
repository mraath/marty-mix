---
created: 2026-02-26T11:45
updated: 2026-02-26T12:30
---
# AWS Discovery: automation-api.dev.mixtelematics.com

## 📋 Summary

| Component | Details |
|---|---|
| **ECS Cluster** | `DEV-Config` |
| **ECS Service** | `dev-powerfleet-automation-api` (1/1 running ✅) |
| **Task Definition** | `dev-powerfleet-automation-api:6` |
| **Load Balancer** | `DEV-Config-ExternalALB` (internet-facing application) |
| **Target Group** | `dev-powerfleet-automation-api` (HTTP:80) |
| **Security Group** | `sg-0514f9a34b60d28af` |
| **Public URLs** | `automation-api.dev.mixtelematics.com`, `automation.dev.mixtelematics.com`, `mixconfigfrangularapi.dev.mixtelematics.com`, `mixconfigfrangularui.dev.mixtelematics.com` |

## 🏗️ Architecture Diagram

![Diagram](file:///c:/Projects/marty-mix/Excalidraw/automation-api.dev.mixtelematics.com%20AWS%20Breakdown.excalidraw)

## 🐳 ECS Service Details
- **Cluster**: `DEV-Config`
- **Service**: `dev-powerfleet-automation-api`
- **Task Definition**: `arn:aws:ecs:eu-west-1:601704920959:task-definition/dev-powerfleet-automation-api:6`
- **Region**: `eu-west-1`

## ⚖️ Load Balancing
- **Load Balancer**: `DEV-Config-ExternalALB`
- **DNS Name**: `DEV-Config-ExternalALB-241706462.eu-west-1.elb.amazonaws.com`
- **Scheme**: `internet-facing`
- **Target Group**: `dev-powerfleet-automation-api`

## ☁️ Networking & Route53
- **Security Group**: `sg-0514f9a34b60d28af`
- **Subnets**: `subnet-08392d2f101c7bd64`, `subnet-08277f6d9702ec037`
- **Public DNS Records**:
    - `automation-api.dev.mixtelematics.com` (CNAME)
    - `automation.dev.mixtelematics.com` (A)
    - `mixconfigfrangularapi.dev.mixtelematics.com` (A)
    - `mixconfigfrangularui.dev.mixtelematics.com` (A)
