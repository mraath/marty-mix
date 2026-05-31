---
wiki_ingested: 2026-05-28
created: 2026-02-20T09:36
updated: 2026-02-20T09:37
---
Full infrastructure breakdown for the internal dev-config-api service.

### 🏗️ Architecture

![[api.deviceconfig.dev.priv AWS Breakdown.excalidraw]]

![api.deviceconfig.dev.priv AWS Breakdown](file:///c:/Projects/marty-mix/Excalidraw/api.deviceconfig.dev.priv%20AWS%20Breakdown.excalidraw)

### 🔧 Components
- **ECS Service**: `dev-config-api`
- **Cluster**: `DEV-Config`
- **Internal ALB**: `DEV-DI-API-ALB`
- **Target Group**: `dev-config-api-TG`
- **Security Group**: `sg-0d683582d7a28e8c9`
- **Subnets**: `subnet-08d8e0c0433dd81a5`, `subnet-0e9016c752a592929`

### 🌐 DNS
- `api.deviceconfig.dev.priv` -> `A` Record (Internal ALB)
- `config.dev.priv` -> `A` Record (Internal ALB)