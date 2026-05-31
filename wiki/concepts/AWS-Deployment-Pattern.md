---
type: concept
name: AWS Deployment Pattern
aliases:
  - New Region Deployment
  - ECS Fargate Deployment
sources:
  - Global_Deployment_Guide.md
  - Automation Infrastructure Setup Guide.md
  - AU-Automation-Setup-Summary.md
  - au_infrastructure_audit_and_fixes.md
last_updated: 2026-05-28
---

The standard pattern for deploying Powerfleet.Automation to a new AWS region. Each region needs the same 4 linked components: Target Groups → ALB Listener Rules → Task Definitions → ECS Services.

## Pre-Requisites (must exist in target region)

- VPC with ≥2 private subnets
- Security Group: ECS SG with **outbound All Traffic `0.0.0.0/0`** (critical for ECR pull via NAT)
- Internal ALB
- IAM Roles: `ecsTaskExecutionRole` + task-specific role
- ECR Repositories: `{region}-powerfleet-automation-ui` and `-api`

## The 4 Components

### 1. Target Groups
- Type: `ip` (Fargate requirement)
- UI: HTTP/3000, health check `/` → 200
- API: HTTP/80, health check `/swagger/index.html` or `/health` → 200

### 2. ALB Listener Rules
- `Host is automation-{region}.mixtelematics.com` → UI Target Group
- `Host is automation-api-{region}.mixtelematics.com` → API Target Group
- **⚠️ Never use dot-notation** (`automation.au.*`) — wildcard cert only covers one level

### 3. Task Definitions
- Network mode: `awsvpc`
- Image: local region ECR (never cross-region)
- Env vars: `ASPNETCORE_ENVIRONMENT`, `NEXT_PUBLIC_API_URL`
- `ASPNETCORE_ENVIRONMENT` must match `appsettings.{ENV}.json` **exactly** (case-sensitive on Linux)

### 4. ECS Services
- Launch type: `FARGATE`
- Network: same private subnets as ALB
- LB mapping: container port → Target Group

## Public Access Pattern (Private ALB)

When the ALB is private (e.g. AU), use API Gateway HTTP Proxy:
1. Create HTTP API with VPC Link to private subnets
2. Private integration → Internal ALB on port 80
3. **Parameter Mapping**: `overwrite:header.host` → `automation-{region}.mixtelematics.com`
4. Catch-all `$default` route
5. API Gateway Custom Domains with `*.mixtelematics.com` cert
6. Route 53 A-alias records → API Gateway regional endpoints
> Wait up to 40 min for TLS propagation after creating Custom Domains.

## URL Convention (MANDATORY)

`automation-{region}.mixtelematics.com` (hyphen) — NOT `automation.{region}.mixtelematics.com` (dot)

| ✅ Correct | ❌ Wrong |
|---|---|
| `automation-au.mixtelematics.com` | `automation.au.mixtelematics.com` |
| `automation-api-au.mixtelematics.com` | `automation-api.au.mixtelematics.com` |

## Common Failure Modes

| Symptom | Cause | Fix |
|---|---|---|
| `ResourceInitializationError: i/o timeout` | ECR pull blocked (SG missing outbound) | Add `All Traffic 0.0.0.0/0` outbound to ECS SG |
| Tasks pulling wrong image | Cross-region ECR URI in task def | Update Task Definition to point to local ECR |
| API crashes, loading DEV URLs | Wrong `ASPNETCORE_ENVIRONMENT` casing | Rename `appsettings.{ENV}.json` to match exactly |
| ECS stuck cycling (Circuit Breaker) | Stale task definitions | Scale to 0, force new deployment |
| `ERR_TLS_CERT_ALTNAME_INVALID` | Dot-notation subdomain | Use hyphenated domain format |

## Connections

- [[Powerfleet-Automation-AWS]] — implementation per environment
- [[AWS-Environments]] — account and URL map
- [[ZAGOV-Environment]] — ZAGOV-specific deployment (different auth, `powerfleet.com` domain)
- [[Ops-Tools]] — project that owns these deployments
