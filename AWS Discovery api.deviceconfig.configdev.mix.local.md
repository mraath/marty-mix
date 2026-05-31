---
wiki_ingested: 2026-05-28
created: 2026-02-20T09:46
updated: 2026-02-25T12:17
---
# AWS Discovery api.deviceconfig.configdev.mix.local

Infrastructure breakdown for the service.

## 🏗️ Architecture
![Diagram](file:///c:/Projects/marty-mix/Excalidraw/api.deviceconfig.configdev.mix.local%20AWS%20Breakdown.excalidraw)

## 🔧 Components
- **ECS Service**: `dev-config-api`
- **Cluster**: `DEV-Config`
- **Internal ALB**: `DEV-DI-API-ALB`
- **Target Group**: `dev-config-api-TG`

## 🌐 Endpoints
- `api.deviceconfig.configdev.mix.local` (Local/On-prem DNS)
- `api.deviceconfig.dev.priv` (Internal AWS DNS)
