---
type: entity
entity_type: System
name: Powerfleet Automation AWS
aliases:
  - Automation Infrastructure
  - ECS Automation
  - Powerfleet.Automation ECS
sources:
  - Automation Infrastructure Setup Guide.md
  - Global_Deployment_Guide.md
  - AU-Automation-Setup-Summary.md
  - au_infrastructure_audit_and_fixes.md
  - AWS_TAGS.md
  - Automation UI URLs.md
  - AWS Troubleshooting and Python Learnings.md
last_updated: 2026-05-28
---

The AWS infrastructure for the Powerfleet.Automation project. Each environment runs two ECS Fargate services (UI + API) behind an ALB, deployed via Azure DevOps pipelines to separate AWS accounts per region.

## Standard Per-Environment Components

| Component | Pattern |
|---|---|
| ECS Cluster | `{ENV}-Config` |
| UI Service | `{env}-powerfleet-automation-ui` (port 3000) |
| API Service | `{env}-powerfleet-automation-api` (port 80) |
| ALB | `{ENV}-Config-InternalALB` or `{ENV}-Config-ExternalALB` |
| CloudWatch Logs | `/ecs/{env}-powerfleet-automation-ui` / `-api` |
| ECR | `{env}-powerfleet-automation-ui:latest` / `-api:latest` |

## Critical Rules

- **URL format**: Always `automation-{env}.mixtelematics.com` (hyphenated) — `*.mixtelematics.com` wildcard cert only covers one subdomain level
- **ECR image**: Must pull from **local region ECR** — cross-region pull causes `ResourceInitializationError`
- **Security Group egress**: ECS SG MUST have `All Traffic 0.0.0.0/0` outbound — without it, tasks can't pull images from ECR via NAT Gateway
- **`ASPNETCORE_ENVIRONMENT`**: Must match the env exactly (case-sensitive on Linux containers) — wrong casing silently falls back to `appsettings.json` (DEV URLs)
- **Subnet alignment**: ECS tasks must run in same AZs as ALB

## AU Environment (ap-southeast-2, account 365528985733)

- API Gateway HTTP Proxy required (private ALB, DNS hijacking issue with `*.au.*`)
- API GW ID: `oroqo28ut0` | VPC Link: `53iyqq` | ACM Cert ARN: `arn:aws:acm:ap-southeast-2:365528985733:certificate/720bfd98-5065-47e6-a94d-8227d72dc1ad`
- Host header must be overridden: `overwrite:header.host = automation-au.mixtelematics.com`
- Python 3.12 only (3.11/3.13 corrupted); use `AWSPowerShell` module or `saml2aws` for auth

## DEV Verified Resources

| Component | Name |
|---|---|
| Cluster | `DEV-Config` |
| UI Service | `dev-powerfleet-automation-ui` |
| API Service | `dev-powerfleet-automation-api` |

## Environment Variables (ECS Task Definition)

| Variable | Value |
|---|---|
| `ASPNETCORE_ENVIRONMENT` | `DEV` / `INT` / `UAT` / `Production` / `zagov` |
| `Environment` | `DEV` / `INT` / `ZA` / `AU` / etc. |

## AWS Tagging Convention (AU, Config team standard)

| Tag | Value |
|---|---|
| `Environment` | `AU` / `ZA` / etc. |
| `DomainResponsible` | `Config` |
| `Product` | `Automation` |
| `TeamResponsible` | `Config` |

## Known Issues

- **ZAGOV `appsettings.ZAGOV.json`**: Linux is case-sensitive — file must be uppercase `ZAGOV`, not `zagov`
- **AU Python corruption**: AWS CLI v2 broken; use `AWSPowerShell` module instead
- **ENT**: CI/CD pipelines done (OPEN-1929/1931); AWS infra (ECS, ALB, DNS) not yet set up

## Connections

- [[AWS-Environments]] — account and URL master map
- [[ZAGOV-Environment]] — isolated ZAGOV account detail
- [[AWS-Deployment-Pattern]] — step-by-step new region guide
- [[Ops-Tools]] — parent project
