---
created: 2026-03-02T10:36
updated: 2026-03-02T10:36
---
# Manual Setup Guide: Powerfleet Automation Infrastructure

This guide provides the exact manual steps taken to set up the Powerfleet Automation UI and API in the **DEV** environment, which can be replicated for the **AU** environment.

---

## Part 1: DEV Environment Setup (Retrospective)

### 1. ECR Repositories
*   **Action**: Create two repositories to hold the Docker images.
*   **Names**:
    *   `powerfleet-automation-ui`
    *   `powerfleet-automation-api`
*   **Steps**: Push initially built images using the `AWS CLI` (authenticate via `saml2aws`).

### 2. Target Groups
*   **Action**: Create Target Groups in the **eu-west-1** region.
*   **UI Target Group**:
    *   **Name**: `dev-powerfleet-automation-ui`
    *   **Target Type**: IP (Fargate)
    *   **Protocol**: HTTP (Port 3000)
    *   **Health Check**: `/`
*   **API Target Group**:
    *   **Name**: `dev-powerfleet-automation-api`
    *   **Target Type**: IP (Fargate)
    *   **Protocol**: HTTP (Port 80)
    *   **Health Check**: `/health`

### 3. ECS Task Definitions
*   **Action**: Create Fargate Task Definitions.
*   **UI Task Definition (`dev-powerfleet-automation-ui`)**:
    *   **Container**: `dev-powerfleet-automation-ui`
    *   **Port Mapping**: 3000
    *   **Env Vars**:
        *   `NEXT_PUBLIC_API_URL`: `https://automation-api.dev.mixtelematics.com`
*   **API Task Definition (`dev-powerfleet-automation-api`)**:
    *   **Container**: `dev-powerfleet-automation-api`
    *   **Port Mapping**: 80
    *   **Env Vars**:
        *   `ASPNETCORE_ENVIRONMENT`: `Development`
        *   `Environment`: `DEV`

### 4. ECS Services
*   **Action**: Deploy the tasks into the `DEV-Config` cluster.
*   **Deployment**:
    *   **Capacity Provider**: FARGATE
    *   **Security Group**: `sg-0514f9a34b60d28af` (Allow 3000 and 80 from ALB)
*   **Load Balancing**: Map the services to their respective Target Groups created in Step 2.

### 5. ALB Listener Rules
*   **Action**: Add routing rules to `DEV-Config-ExternalALB` on **HTTPS:443**.
*   **Rule 1 (UI)**:
    *   **Condition**: Host Header is `automation.dev.mixtelematics.com`
    *   **Action**: Forward to `dev-powerfleet-automation-ui`
*   **Rule 2 (API)**:
    *   **Condition**: Host Header is `automation-api.dev.mixtelematics.com`
    *   **Action**: Forward to `dev-powerfleet-automation-api`

### 6. Route 53 DNS
*   **Action**: Create **A (Alias)** records.
*   **Records**:
    *   `automation.dev.mixtelematics.com` -> Alias to `DEV-Config-ExternalALB`
    *   `automation-api.dev.mixtelematics.com` -> Alias to `DEV-Config-ExternalALB`

---

## Part 2: AU Environment Setup (Step-by-Step)

Follow these steps in the **operationsmixtelematics (365528985733)** account in the **ap-southeast-2 (Sydney)** region.

### 1. Target Groups
*   Create `au-powerfleet-automation-ui` (Port 3000, IP, Health: `/`).
*   Create `au-powerfleet-automation-api` (Port 80, IP, Health: `/health`).

### 2. Task Definitions
*   **UI**: Use the same image, set `NEXT_PUBLIC_API_URL` to `https://automation-api.config.au.priv` (or your preferred AU internal/external URL).
*   **API**: Set `ASPNETCORE_ENVIRONMENT` to `Production` (as per standard AU setup) and `Environment` to `AU`.

### 3. ECS Services
*   Deploy into the `AU-Config` cluster.
*   Use Security Group `sg-09d97cfc127d25b95`.

### 4. ALB Listener Rules
*   On `AU-Config-InternalALB` (or External if needed), add host-header rules:
    *   `automation.config.au.priv` -> Forward to UI Target Group.
    *   `automation-api.config.au.priv` -> Forward to API Target Group.

### 5. Route 53
*   Create Alias records in the internal/private hosted zone for the above URLs pointing to the ALB.
