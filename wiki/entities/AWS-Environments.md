---
type: entity
entity_type: System
name: AWS Environments
aliases:
  - AWS Accounts
  - MiX AWS
sources:
  - AWS Servers.md
  - Automation UI URLs.md
last_updated: 2026-05-28
---

Master map of all AWS accounts and Powerfleet Automation environment URLs.

## AWS Account Map

| Account Name | Account ID | Environment | Region |
|---|---|---|---|
| `mixdevelopment` | `601704920959` | DEV + INT | eu-west-1 |
| `operationsmixtelematics` | `365528985733` | AU / US / UK / UAE | ap-southeast-2 / us-east-1 / eu-west-1 / ap-south-1 |
| `mix-cpt-operations` | `668736068906` | ZA | — |
| `mixenterprise` | `522301445307` | ENT | eu-west-1 |
| `mixuat` | `059521945538` | UAT | eu-west-1 |
| `120736098406` (ZAGOV) | `120736098406` | ZA GOV | af-south-1 (Cape Town) |
| `businessmixtelematics` | `870659986017` | — | — |
| `mixsharedservices` | `071458019214` | — | — |

## Automation UI & API URLs (All Environments)

| Env | UI | API |
|---|---|---|
| INT | `automation.mixdevelopment.com` | `automation-api.mixdevelopment.com/swagger` |
| UAT | `automation.uat.mixtelematics.com` | `automation-api.uat.mixtelematics.com/swagger` |
| UAE | `automation.ae.mixtelematics.com` | `automation-api.ae.mixtelematics.com/swagger` |
| AU ⚠️ | `automation-au.mixtelematics.com` | `automation-api-au.mixtelematics.com/swagger` |
| UK | `automation.uk.mixtelematics.com` | `automation-api.uk.mixtelematics.com/swagger` |
| US | `automation.us.mixtelematics.com` | `automation-api.us.mixtelematics.com/swagger` |
| ZA | `automation.za.mixtelematics.com` | `automation-api.za.mixtelematics.com/swagger` |
| ENT | `automation.ent.mixtelematics.com` | `automation-api.ent.mixtelematics.com/swagger` |
| ZAGOV | `automation-zagov.powerfleet.com` | `automation-api-zagov.powerfleet.com/swagger` |

> **AU note**: Uses `automation-au` (hyphenated) not `automation.au` (dotted) — wildcard cert limitation. INT is on `mixdevelopment.com`, not `mixtelematics.com`.

## Authentication

- Most envs: `saml2aws login -a <env>` (Okta)
- AU specifically: `saml2aws login --role arn:aws:iam::365528985733:role/MiX-DevOpsAdmin`
- ZAGOV: Microsoft Entra ID federated — manual portal creds every ~1h, profile `120736098406_MiX-DevOpsAdmin`

## Connections

- [[Powerfleet-Automation-AWS]] — infrastructure detail per environment
- [[ZAGOV-Environment]] — isolated ZAGOV account
- [[Ops-Tools]] — project that owns these environments
- [[AWS-Deployment-Pattern]] — how to deploy a new region
