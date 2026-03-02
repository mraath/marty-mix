---
created: 2026-02-26T11:48
updated: 2026-03-02T09:28
---
# AWS Discovery: ecs-api.config.int.priv

## 📋 Summary

| Component           | Details                                                                            |
| ------------------- | ---------------------------------------------------------------------------------- |
| **ECS Cluster**     | `INT-Config`                                                                       |
| **ECS Service**     | `int-config-api` (2/2 running ✅)                                                   |
| **Task Definition** | `int-config-api:7`                                                                 |
| **Load Balancer**   | `INT-DI-API-ALB` (internal application)                                            |
| **Target Group**    | `int-config-api-TG` (HTTP:80)                                                      |
| **Security Group**  | `sg-09d9e1223188d85ff`                                                             |
| **Public URLs**     | `ecs-api.config.int.priv`, `configapi.int.priv`, `api.config.devicestate.int.priv` |

## 🏗️ Architecture Diagram

![Diagram](file:///c:/Projects/marty-mix/Excalidraw/ecs-api.config.int.priv%20AWS%20Breakdown.excalidraw)

## 🐳 ECS Service Details
- **Cluster**: `INT-Config`
- **Service**: `int-config-api`
- **Task Definition**: `arn:aws:ecs:eu-west-1:601704920959:task-definition/int-config-api:7`
- **Region**: `eu-west-1`

## ⚖️ Load Balancing
- **Load Balancer**: `INT-DI-API-ALB`
- **DNS Name**: `internal-INT-DI-API-ALB-888684388.eu-west-1.elb.amazonaws.com`
- **Scheme**: `internal`
- **Target Group**: `int-config-api-TG`

## ☁️ Networking & Route53
- **Security Group**: `sg-09d9e1223188d85ff`
- **Subnets**: `subnet-19f90d50`, `subnet-0054956d95b3b4346`, `subnet-198e647e`, `subnet-2fb38677`, `subnet-0374145694d7bbf64`, `subnet-002b12b84ce97b4be`
- **Private DNS Records**:
    - `ecs-api.config.int.priv` (CNAME)
    - `configapi.int.priv` (A)
    - `api.config.devicestate.int.priv` (A)
