---
created: 2026-05-25T09:00
updated: 2026-05-26T11:00
tags: [aws, zagov, deployment, opstools]
---

# ZAGOV — Powerfleet Automation Deployment

ZA Government production environment. Isolated AWS account, separate auth model from all other envs.

> ⚠️ This account uses **AWS IAM Identity Center federated via Microsoft Entra ID**, not Okta SAML. `saml2aws login -a zagov` and `aws sso login` both fail. Credentials must be fetched manually from the AWS access portal every ~1 hour.

---

## Quick Reference

| | |
|---|---|
| **Account ID** | `120736098406` |
| **Region** | `af-south-1` (Cape Town) |
| **Login** | AWS access portal → ZA GOV Prod → MiX-DevOpsAdmin → Windows tab → Option 2 into `~/.aws/credentials` as `[120736098406_MiX-DevOpsAdmin]` |
| **UI** | https://automation-zagov.powerfleet.com |
| **API** | https://automation-api-zagov.powerfleet.com |
| **API Swagger** | https://automation-api-zagov.powerfleet.com/swagger/index.html |

---

## Resource Inventory

### Networking

| Resource | Name / ID | Notes |
|---|---|---|
| VPC | `vpc-094a9cfefa4e52d9a` | Shared with all ZAGOV services |
| Private Subnet 1a | `subnet-0efb30230680ec200` | ECS tasks run here |
| Private Subnet 1b | `subnet-0efc590c746d20dee` | ECS tasks run here |
| Public Subnet 1a | `subnet-0dd56f4a54f3a1b62` | ALB lives here |
| Public Subnet 1b | `subnet-09a1ac015dcdd11e7` | ALB lives here |
| ALB SG | `sg-05f3102eb97a4eb0a` | `ZAGOV-Config-ExternalALB-SG` — allows 80/443 inbound from internet; egress 80+3000 → ECS SG |
| ECS SG | `sg-0427a71992fca7cc0` | `ZAGOV-Config-ApiService` — allows 80+3000 inbound from ALB SG only |

### Load Balancer

| Resource | Value |
|---|---|
| ALB Name | `ZAGOV-Config-ExternalALB` |
| ALB ARN | `arn:aws:elasticloadbalancing:af-south-1:120736098406:loadbalancer/app/ZAGOV-Config-ExternalALB/deca8df46ad363da` |
| ALB DNS | `ZAGOV-Config-ExternalALB-536202983.af-south-1.elb.amazonaws.com` |
| ALB Hosted Zone ID | `Z268VQBMOI5EKX` ← needed for Route 53 alias records |
| HTTPS Listener (443) | `arn:aws:elasticloadbalancing:af-south-1:120736098406:listener/app/ZAGOV-Config-ExternalALB/deca8df46ad363da/5f3773ab378223f3` |
| HTTP Listener (80) | `arn:aws:elasticloadbalancing:af-south-1:120736098406:listener/app/ZAGOV-Config-ExternalALB/deca8df46ad363da/5896e2a03706127f` |
| ACM Certificate | `*.powerfleet.com` — ARN `arn:aws:acm:af-south-1:120736098406:certificate/adb911e3-c886-4866-96e6-34bebf66ed03` |

**ALB Listener Rules (HTTPS, priorities 5–7):**

| Priority | Host Header | Target |
|---|---|---|
| 5 | `automation-api-zagov.powerfleet.com` | `zagov-powerfleet-automation-api` TG |
| 6 | `powerfleet-automation-zagov.powerfleet.com` | `zagov-powerfleet-automation-ui` TG |
| 7 | `automation-zagov.powerfleet.com` | `zagov-powerfleet-automation-ui` TG |

### ECS

| Resource | Value |
|---|---|
| Cluster | `ZAGOV-Config` |
| API Service | `zagov-powerfleet-automation-api` |
| UI Service | `zagov-powerfleet-automation-ui` |
| API Task Definition | `zagov-powerfleet-automation-api:1` (pipeline updates via force-new-deployment) |
| UI Task Definition | `zagov-powerfleet-automation-ui:2` (pipeline registers new revision each deploy) |
| Task CPU / Memory | 512 CPU / 1024 MB |
| Execution Role | `arn:aws:iam::120736098406:role/ZAGOV-Config-AutomationTaskExecutionRole` |
| API Container Port | 80 |
| UI Container Port | 3000 |

### ECR (Container Registries)

| Repo | URI |
|---|---|
| API | `120736098406.dkr.ecr.af-south-1.amazonaws.com/zagov-powerfleet-automation-api` |
| UI | `120736098406.dkr.ecr.af-south-1.amazonaws.com/zagov-powerfleet-automation-ui` |

### Target Groups

| Name | Port | Health Check | ARN |
|---|---|---|---|
| `zagov-powerfleet-automation-api` | 80 | `/swagger/index.html` | `arn:...:targetgroup/zagov-powerfleet-automation-api/2bceef1e8ee517f7` |
| `zagov-powerfleet-automation-ui` | 3000 | `/` | `arn:...:targetgroup/zagov-powerfleet-automation-ui/8a184a1fc8a0ab92` |

### CloudWatch Logs

| Log Group | Service |
|---|---|
| `/ecs/zagov-powerfleet-automation-api` | API |
| `/ecs/zagov-powerfleet-automation-ui` | UI |

### IAM

| Resource | Value |
|---|---|
| Task Execution Role | `ZAGOV-Config-AutomationTaskExecutionRole` — `AmazonECSTaskExecutionRolePolicy` attached |
| Deployment IAM User | `SrvcDeploy` — policy `OpsTools-Automation-Deploy` (ECR push + ECS update-service + iam:PassRole) |
| Deployment Access Key | `AKIARYHDOVBTB4LL4DNC` (stored in ADO service connection) |

### Database

| | |
|---|---|
| SQL Server | `hscptcln01.dublin.production.local\SQLZERO,58910` (same server as ZA) |
| Credentials | `UID=ConfigServices;PWD=ConfigPass` |
| `ASPNETCORE_ENVIRONMENT` | `zagov` → loads `appsettings.zagov.json` from baked image |
| Aurora PostgreSQL | ✅ `mix-zagov-aurpg01` — provisioned 2026-05-26, engine 15.8 |
| Aurora Endpoint | `mix-zagov-aurpg01.cluster-clygwk4ka8zo.af-south-1.rds.amazonaws.com` |
| Aurora DB | `operations_tools` — app user `operations_tools_admin` |
| Aurora RDS SG | `sg-0136fd2e44fce4185` (reused from Extensibility, allows TCP 5432 from `0.0.0.0/0`) |
| Subnet Group | `zagov-extensibility-aurorapostgresshared-...x6t9gtkug3y0` (reused from Extensibility) |
| `OperationsToolsDb` env var | Set in API task definition revision 2 — `Host=mix-zagov-aurpg01.cluster-clygwk4ka8zo.af-south-1.rds.amazonaws.com;Port=5432;Database=operations_tools;Username=operations_tools_admin;Password=<secret>` |
| Migration applied | `001_configdiff_postgresql.sql` — `configdiffcases`, `configdiffcaseassets`, `configdiffcasediffs` all verified ✅ |
| Shared Aurora (Extensibility) | `zagov-extensibility-aurorapostgresshared-rds.cluster-clygwk4ka8zo.af-south-1.rds.amazonaws.com` — NOT used, dedicated cluster provisioned instead |

### CI/CD

| Resource | Value |
|---|---|
| ADO Service Connection | `srvcdeploy-zagov-OperationsTools` (id: `a24d1221-778b-4a3e-b212-7a40eb087b56`) |
| ADO Environment | `ZAGOV` (id: 467) |
| API Pipeline Branch | `feature/OPEN-ZAGOV-pipeline-stage` → **⚠️ PR to `integration` still pending** |
| UI Pipeline Branch | `Config/MR/Feature/OPEN-2426_PipelineAutoDeployUAEUAT` → **⚠️ PR to `integration` still pending** |
| Pipeline Trigger | **Manual only** — `ForceDeployZAGOV = true` parameter (never auto-triggers on branch push) |

---

## Deployment Status (2026-05-26)

| Service | Status | Task Def | Image |
|---|---|---|---|
| `zagov-powerfleet-automation-ui` | ✅ DEPLOYED | `:2` | `zagov-powerfleet-automation-ui:latest` |
| `zagov-powerfleet-automation-api` | ✅ DEPLOYED + PostgreSQL configured | `:2` | `zagov-powerfleet-automation-api:latest` |
| Aurora PostgreSQL | ✅ PROVISIONED | `mix-zagov-aurpg01` (15.8) | migrations applied + verified |

> **API health-check failure — root cause & fix:** After the first pipeline run the API entered a crash loop (`IN_PROGRESS`, tasks cycling every ~90 s). CloudWatch logs showed `Attempting to get settings from http://authentication.mixdevelopment.com` — the base `appsettings.json` default, not the ZAGOV values.
>
> **Cause:** The settings loader calls `.ToUpper()` on the environment name and loads `appsettings.ZAGOV.json`. The file was accidentally created as `appsettings.zagov.json` (all lowercase). In the Linux Docker container the filesystem is case-sensitive, so the file was silently skipped (`optional: true`) and the app fell back to `appsettings.json` (DEV URLs).
>
> **Fix:** Renamed to `appsettings.ZAGOV.json` on branch `feature/OPEN-ZAGOV-pipeline-stage` (commit `875445b`). Run the API pipeline again with `ForceDeployZAGOV=true` to deploy the corrected image.

---

## 🔴 Outstanding Items

### 1. DNS — powerfleet.com records

Need two Route 53 **A-alias records** in whichever account owns the `powerfleet.com` zone (not found in ZAGOV / ZA / DEV accounts — check with infra/network team):

| DNS Record | Alias Target | Hosted Zone ID |
|---|---|---|
| `automation-zagov.powerfleet.com` | `ZAGOV-Config-ExternalALB-536202983.af-south-1.elb.amazonaws.com` | `Z268VQBMOI5EKX` |
| `automation-api-zagov.powerfleet.com` | same ALB | `Z268VQBMOI5EKX` |

### 2. Merge Pipeline PRs

Raise PRs for both pipeline YAML changes → `integration` so future ZAGOV deployments run from the standard branch:
- `Powerfleet.Automation`: branch `feature/OPEN-ZAGOV-pipeline-stage`
- `Powerfleet.Automation.UI`: branch `Config/MR/Feature/OPEN-2426_PipelineAutoDeployUAEUAT`

### 3. Config Delta (OperationsToolsDb) — ✅ DONE (2026-05-26)

Dedicated Aurora cluster provisioned, `001_configdiff_postgresql.sql` applied, `OperationsToolsDb` updated in API task definition revision 2. Config Delta feature is live.

---

## How to Log In (Future Sessions)

ZAGOV uses **Microsoft-federated AWS IAM Identity Center** — credentials are temporary (~1h) and must be fetched from the portal each session:

1. Open [AWS access portal](https://identitycenter.amazonaws.com/ssoins-680461a3989172ff)
2. Navigate to **ZA GOV Prod → MiX-DevOpsAdmin → Windows tab**
3. Copy the **Option 2** block and paste into `%USERPROFILE%\.aws\credentials` under `[120736098406_MiX-DevOpsAdmin]`
4. Then:
```powershell
$env:AWS_PROFILE = "120736098406_MiX-DevOpsAdmin"
aws sts get-caller-identity  # Confirm: "Account": "120736098406"
```

---

## Key Differences from Other Environments

| | ZAGOV | ZA / AU / others |
|---|---|---|
| Auth | Microsoft-federated IAM Identity Center (temp creds from portal, profile `120736098406_MiX-DevOpsAdmin`) | Okta SAML (`saml2aws login -a <env>`) |
| Domain | `powerfleet.com` | `mixtelematics.com` |
| Region | `af-south-1` (Cape Town) | eu-west-1 / ap-southeast-2 / etc. |
| Tag policy | Restricts `TeamResponsible` — omit it | Allows `OpsTools` / `Config` values |
| Pipeline trigger | Manual only | Auto on `production` branch push |
| OperationsToolsDb | Empty — Config Delta not set up | Configured Aurora endpoint |
| saml2aws profile | ❌ Does not work — use portal temp creds | ✅ `saml2aws login -a <env>` |
| ECR naming | `zagov-powerfleet-automation-*` | `<env>-powerfleet-automation-*` |
