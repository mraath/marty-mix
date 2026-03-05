---
created: 2026-03-05
updated: 2026-03-05
tags:
  - aws
  - ecs
  - tagging
  - au
  - automation
status: done
ticket: OPEN-1715
---

# AWS Tagging — AU Powerfleet Automation Resources

**Date**: 2026-03-05
**Ticket**: [[OPEN-1715 Setup UI and API on AWS for AU]]
**Related**: [[AU-Automation-Setup-Summary]]

## 🎯 Goal

Apply consistent AWS resource tags to all Powerfleet Automation resources in the AU region (`ap-southeast-2`), matching the tagging convention used by the Config team (visible on `au-config-frangular-api`).

---

## 🏷️ Tag Convention (from au-config-frangular-api example)

| Tag Key             | Config Team Example | Proposed for Automation                   |
| ------------------- | ------------------- | ----------------------------------------- |
| `Environment`       | `AU`                | `AU` ✅ confirmed                          |
| `DomainResponsible` | `Config`            | `Config` ✅ confirmed                      |
| `Product`           | `Automation`        | `Automation` ✅ confirmed                  |
| `TeamResponsible`   | `Config`            | `Config` ✅ confirmed                      |

---

## 📦 Resources to Tag (all currently have ZERO tags)

| # | Resource Type | Name | ARN / ID |
|---|---|---|---|
| 1 | ECS Service | `au-powerfleet-automation-ui` | `arn:aws:ecs:ap-southeast-2:365528985733:service/AU-Config/au-powerfleet-automation-ui` |
| 2 | ECS Service | `au-powerfleet-automation-api` | `arn:aws:ecs:ap-southeast-2:365528985733:service/AU-Config/au-powerfleet-automation-api` |
| 3 | ECS Task Definition | `au-powerfleet-automation-ui:5` | `arn:aws:ecs:ap-southeast-2:365528985733:task-definition/au-powerfleet-automation-ui:5` |
| 4 | ECS Task Definition | `au-powerfleet-automation-api:5` | `arn:aws:ecs:ap-southeast-2:365528985733:task-definition/au-powerfleet-automation-api:5` |
| 5 | ALB Target Group | `au-powerfleet-automation-ui` | `arn:aws:elasticloadbalancing:ap-southeast-2:365528985733:targetgroup/au-powerfleet-automation-ui/bba22c6037e8e260` |
| 6 | ALB Target Group | `au-powerfleet-automation-api` | `arn:aws:elasticloadbalancing:ap-southeast-2:365528985733:targetgroup/au-powerfleet-automation-api/6ffc714e97cc94eb` |
| 7 | API Gateway (HTTP API) | `AU-Powerfleet-Automation-Proxy` | API ID: `oroqo28ut0` |
| 8 | VPC Link | `AU-Automation-VPCLink` | ID: `53iyqq` |
| 9 | API GW Custom Domain | `automation-au.mixtelematics.com` | — |
| 10 | API GW Custom Domain | `automation-api-au.mixtelematics.com` | — |
| 11 | ECR Repository | `au-powerfleet-automation-ui` | `arn:aws:ecr:ap-southeast-2:365528985733:repository/au-powerfleet-automation-ui` |
| 12 | ECR Repository | `au-powerfleet-automation-api` | `arn:aws:ecr:ap-southeast-2:365528985733:repository/au-powerfleet-automation-api` |

---

## 📝 Planned Script (PowerShell — NOT YET RUN)

> Update `$domainResponsible`, `$product`, and `$teamResponsible` values before running.

```powershell
# ============================================================
# AU Powerfleet Automation — AWS Resource Tagging Script
# Ticket: OPEN-1715
# Date: 2026-03-05
# ============================================================
# BEFORE RUNNING: Confirm tag values below with the team.
# Ensure you are authenticated via SAML for account 365528985733.
# ============================================================

$region         = "ap-southeast-2"
$environment    = "AU"

# ⚠️ CONFIRM THESE VALUES:
$domainResponsible = "Automation"   # or "Powerfleet"?
$product           = "Automation"   # or "Powerfleet"?
$teamResponsible   = "Automation"   # or "Powerfleet"?

$tags = "Key=Environment,Value=$environment Key=DomainResponsible,Value=$domainResponsible Key=Product,Value=$product Key=TeamResponsible,Value=$teamResponsible"

Write-Host "Tagging AU Powerfleet Automation resources..." -ForegroundColor Cyan
Write-Host "Tags: Environment=$environment | DomainResponsible=$domainResponsible | Product=$product | TeamResponsible=$teamResponsible" -ForegroundColor Yellow

# --- 1. ECS Services ---
Write-Host "`n[1/8] ECS Services..." -ForegroundColor Green
aws ecs tag-resource --region $region `
  --resource-arn "arn:aws:ecs:ap-southeast-2:365528985733:service/AU-Config/au-powerfleet-automation-ui" `
  --tags $tags.Split(" ")
aws ecs tag-resource --region $region `
  --resource-arn "arn:aws:ecs:ap-southeast-2:365528985733:service/AU-Config/au-powerfleet-automation-api" `
  --tags $tags.Split(" ")

# --- 2. ECS Task Definitions (active revision :5) ---
Write-Host "[2/8] ECS Task Definitions (revision :5)..." -ForegroundColor Green
aws ecs tag-resource --region $region `
  --resource-arn "arn:aws:ecs:ap-southeast-2:365528985733:task-definition/au-powerfleet-automation-ui:5" `
  --tags $tags.Split(" ")
aws ecs tag-resource --region $region `
  --resource-arn "arn:aws:ecs:ap-southeast-2:365528985733:task-definition/au-powerfleet-automation-api:5" `
  --tags $tags.Split(" ")

# --- 3. ALB Target Groups ---
Write-Host "[3/8] ALB Target Groups..." -ForegroundColor Green
aws elbv2 add-tags --region $region `
  --resource-arns "arn:aws:elasticloadbalancing:ap-southeast-2:365528985733:targetgroup/au-powerfleet-automation-ui/bba22c6037e8e260" `
  --tags $tags.Split(" ")
aws elbv2 add-tags --region $region `
  --resource-arns "arn:aws:elasticloadbalancing:ap-southeast-2:365528985733:targetgroup/au-powerfleet-automation-api/6ffc714e97cc94eb" `
  --tags $tags.Split(" ")

# --- 4. API Gateway (HTTP API) ---
Write-Host "[4/8] API Gateway..." -ForegroundColor Green
aws apigatewayv2 tag-resource --region $region `
  --resource-arn "arn:aws:apigateway:ap-southeast-2::/apis/oroqo28ut0" `
  --tags "Environment=$environment,DomainResponsible=$domainResponsible,Product=$product,TeamResponsible=$teamResponsible"

# --- 5. VPC Link ---
Write-Host "[5/8] VPC Link..." -ForegroundColor Green
aws apigatewayv2 tag-resource --region $region `
  --resource-arn "arn:aws:apigateway:ap-southeast-2::/vpclinks/53iyqq" `
  --tags "Environment=$environment,DomainResponsible=$domainResponsible,Product=$product,TeamResponsible=$teamResponsible"

# --- 6. API Gateway Custom Domains ---
Write-Host "[6/8] API Gateway Custom Domains..." -ForegroundColor Green
aws apigatewayv2 tag-resource --region $region `
  --resource-arn "arn:aws:apigateway:ap-southeast-2::/domainnames/automation-au.mixtelematics.com" `
  --tags "Environment=$environment,DomainResponsible=$domainResponsible,Product=$product,TeamResponsible=$teamResponsible"
aws apigatewayv2 tag-resource --region $region `
  --resource-arn "arn:aws:apigateway:ap-southeast-2::/domainnames/automation-api-au.mixtelematics.com" `
  --tags "Environment=$environment,DomainResponsible=$domainResponsible,Product=$product,TeamResponsible=$teamResponsible"

# --- 7. ECR Repositories ---
Write-Host "[7/8] ECR Repositories..." -ForegroundColor Green
aws ecr tag-resource --region $region `
  --resource-arn "arn:aws:ecr:ap-southeast-2:365528985733:repository/au-powerfleet-automation-ui" `
  --tags $tags.Split(" ")
aws ecr tag-resource --region $region `
  --resource-arn "arn:aws:ecr:ap-southeast-2:365528985733:repository/au-powerfleet-automation-api" `
  --tags $tags.Split(" ")

Write-Host "`n✅ Done! All 12 resources tagged." -ForegroundColor Cyan
```

---

## ✅ Next Steps

1. **Confirm** tag values (`Automation` vs `Powerfleet`) for `DomainResponsible`, `Product`, `TeamResponsible`
2. Update the `$domainResponsible`, `$product`, `$teamResponsible` variables in the script above
3. Run the script (requires SAML auth for account `365528985733`)
4. Update `status` in this note's frontmatter to `done`
