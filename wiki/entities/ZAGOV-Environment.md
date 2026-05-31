---
type: entity
entity_type: System
name: ZAGOV Environment
aliases:
  - ZA Government
  - ZA GOV
  - zagov
sources:
  - Notes/ZAGOV-AWS-Deployment.md
last_updated: 2026-05-28
---

ZAGOV is the ZA Government production environment for Powerfleet.Automation. It runs in an isolated AWS account (`120736098406`, af-south-1/Cape Town) with a completely different auth model from all other environments.

## Key Facts

- **Account ID**: `120736098406` | **Region**: `af-south-1` (Cape Town)
- **Domain**: `powerfleet.com` (not `mixtelematics.com`)
- **UI**: `https://automation-zagov.powerfleet.com`
- **API**: `https://automation-api-zagov.powerfleet.com/swagger/index.html`
- **Auth**: Microsoft Entra ID federated IAM Identity Center — credentials from portal only, ~1h TTL. `saml2aws` does NOT work here.
- **Pipeline trigger**: Manual only — `ForceDeployZAGOV = true` parameter
- **Related tickets**: OPEN-2461 (API pipeline, On Hold), OPEN-2462 (UI pipeline, On Hold)

## Infrastructure

| Resource | Value |
|---|---|
| ECS Cluster | `ZAGOV-Config` |
| ALB | `ZAGOV-Config-ExternalALB` (public/internet-facing) |
| ALB DNS | `ZAGOV-Config-ExternalALB-536202983.af-south-1.elb.amazonaws.com` |
| ALB Hosted Zone ID | `Z268VQBMOI5EKX` |
| ACM Certificate | `*.powerfleet.com` |
| ECS SG | `sg-0427a71992fca7cc0` (`ZAGOV-Config-ApiService`) |
| ECR API | `120736098406.dkr.ecr.af-south-1.amazonaws.com/zagov-powerfleet-automation-api` |
| ECR UI | `120736098406.dkr.ecr.af-south-1.amazonaws.com/zagov-powerfleet-automation-ui` |

## Database

- **SQL Server**: `hscptcln01.dublin.production.local\SQLZERO,58910` (same as ZA)
- **Aurora PostgreSQL**: `mix-zagov-aurpg01` (15.8, `af-south-1`) — provisioned 2026-05-26
- **Aurora Endpoint**: `mix-zagov-aurpg01.cluster-clygwk4ka8zo.af-south-1.rds.amazonaws.com`
- **DB**: `operations_tools` | User: `operations_tools_admin`
- Migration `001_configdiff_postgresql.sql` applied and verified ✅

## How to Log In

1. Open AWS access portal
2. Navigate to **ZA GOV Prod → MiX-DevOpsAdmin → Windows tab**
3. Copy **Option 2** block → paste into `~/.aws/credentials` as `[120736098406_MiX-DevOpsAdmin]`
4. `$env:AWS_PROFILE = "120736098406_MiX-DevOpsAdmin"` then `aws sts get-caller-identity`

## Outstanding Items

- [ ] DNS: two A-alias records needed in `powerfleet.com` zone (unknown owner — check with infra team)
- [ ] Merge pipeline PRs to `integration` (both currently on feature branches)
- [ ] OPEN-2461 / OPEN-2462: On Hold — deploy pipelines needed

## Key Differences vs. Other Envs

| | ZAGOV | Others |
|---|---|---|
| Auth | Microsoft Entra (temp portal creds) | Okta SAML |
| Domain | `powerfleet.com` | `mixtelematics.com` |
| Pipeline trigger | Manual only | Auto on `production` push |
| Tag restriction | No `TeamResponsible` tag (policy blocks it) | Allowed |

## Connections

- [[Powerfleet-Automation-AWS]] — standard infrastructure pattern
- [[AWS-Environments]] — account map
- [[Ops-Tools]] — parent project (OPEN-2461/2462)
