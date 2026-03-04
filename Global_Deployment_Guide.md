---
created: 2026-03-04T15:33
updated: 2026-03-04T15:33
---
# Global Deployment Guide: Powerfleet Automation (API & UI)

This guide summarizes the exact AWS infrastructure requirements and commands needed to deploy `powerfleet-automation-ui` and `powerfleet-automation-api` to any new region (e.g., UK, US, AU).

> [!IMPORTANT]
> **URL Naming Convention — MANDATORY**: Always use **hyphens** to separate the environment/region code from the service name. Never use dots (sub-subdomain format). The company's `*.mixtelematics.com` wildcard SSL certificate only covers a single subdomain level.
> - ✅ **Correct**: `automation-au.mixtelematics.com`, `automation-api-au.mixtelematics.com`
> - ❌ **Wrong**: `automation.au.mixtelematics.com`, `automation-api.au.mixtelematics.com`

---

## 1. Prerequisites (Must exist in the target region)
Before running the deployment script, the following infrastructure must already exist in the target AWS region:
* **VPC & Subnets**: At least two private subnets.
* **Security Group**: An ECS Security Group that allows inbound traffic from the Internal ALB, and **CRITICALLY** has an outbound `All Traffic (0.0.0.0/0)` rule so tasks can reach the ECR NAT Gateway.
* **Internal ALB**: An Application Load Balancer to route traffic.
* **IAM Roles**: `ecsTaskExecutionRole` and a specific Task Role (e.g., `ecsAutomationApiRole`).
* **ECR Repositories**: `[region]-powerfleet-automation-ui` and `[region]-powerfleet-automation-api`.

---

## 2. Infrastructure Components Created per Region

For each new region, the following 4 components must be linked together:

### A. Target Groups
You need two Target Groups (one for UI, one for API).
* **Target Type**: `ip` (Required for AWS Fargate).
* **Protocol/Port**: UI = HTTP/3000. API = HTTP/80.
* **Health Checks**: UI = `/` (HTTP 200). API = `/swagger/index.html` or `/health` (HTTP 200).

### B. ALB Listener Rules
The Internal ALB must have rules routing traffic to the Target Groups.
* **Condition**: `Host is automation-[region].mixtelematics.com` -> Forward to UI Target Group.
* **Condition**: `Host is automation-api-[region].mixtelematics.com` -> Forward to API Target Group.

> [!IMPORTANT]
> **SSL Certificate Wildcard Limitation:** Do not use `automation.[region].mixtelematics.com` or `automation-api.[region].mixtelematics.com`. The standard `*.mixtelematics.com` wildcard certificate only covers one subdomain layer. You must use the hyphenated format (`automation-[region].mixtelematics.com`) to avoid `ERR_TLS_CERT_ALTNAME_INVALID` errors in both the browser and the Next.js server-side proxy.

### C. Task Definitions
Defines the Docker container specifications.
* **Network Mode**: `awsvpc`.
* **CPU/Memory**: e.g., 256 CPU (.25 vCPU), 512MB RAM.
* **Image**: Must point to the **LOCAL REGION ECR** (e.g., `[AccountID].dkr.ecr.[Region].amazonaws.com/[region]-powerfleet...`). Do not cross-pull from DEV.
* **Environment Variables**: `ASPNETCORE_ENVIRONMENT=[REGION]`, `NEXT_PUBLIC_API_URL=https://automation-api-[region]...`

### D. ECS Services
Runs and maintains the Task Definitions.
* **Launch Type**: `FARGATE`.
* **Network Configuration**: Must use the exact same Private Subnets as the Internal ALB.
* **Load Balancer**: Map the container port (3000/80) to the respective Target Group created in Step A.

---

## 3. Public Access (Cloud-Native Proxy)

If direct Route 53 CNAMEs are blocked or the ALB is private (like AU where the `*.au` wildcard is hijacked), use an **API Gateway HTTP Proxy**.

1. **Create HTTP API**: Named `[REGION]-Powerfleet-Automation-Proxy`.
2. **Create VPC Link**:
   - Choose HTTP API type.
   - Select VPC and Subnets (matching the Internal ALB).
   - Select Security Group (e.g., `[REGION]-ConfigAPI-SG`).
3. **Add Private Integration**:
   - Target: `Internal ALB`.
   - Protocol: `HTTP` on Port `80`.
   - VPC Link: Select the one created above.
4. **Configure Parameter Mapping (CRITICAL)**:
   - In the Integration settings, add a mapping to overwrite the `Host` header.
   - **Parameter**: `overwrite:header.host`
   - **Value**: `automation-[region].mixtelematics.com` (forces the ALB to match the correct listener rule).
5. **Create Catch-all Route**:
   - Path: `$default` (Greedy match).
   - Attach the Private Integration.
6. **Configure Custom Domain Names** (so the gateway uses your real domain instead of the AWS invoke URL):
   - Create Custom Domain `automation-[region].mixtelematics.com` with the `*.mixtelematics.com` ACM certificate.
   - Create Custom Domain `automation-api-[region].mixtelematics.com` with the same certificate.
   - Add API Mappings for both domains pointing to the proxy API's `$default` stage.
7. **Update Route 53**:
   - Create `A (Alias)` records for both new custom domains pointing to the respective API Gateway regional endpoints.

> [!NOTE]
> After creating new API Gateway Custom Domains, AWS can take **up to 40 minutes** to fully propagate the TLS configuration. Seeing a TLS `InternalError` during this window is normal.

---

## 4. UI Code: `api-urls.ts`

Update `src/environments/api-urls.ts` in the UI project to add the new region with the hyphenated domain format:

```typescript
[region]: {
  auth: "https://automation-api-[region].mixtelematics.com/api/auth",
  qc:   "https://automation-api-[region].mixtelematics.com"
},
```

Also update `src/environments/environment.service.ts` to add the hostname matcher for the new region.

---

## 5. Verification Checklist
- [ ] ECS Tasks are "Running" and targeting the local region ECR.
- [ ] Security Group allows Outbound `All Traffic` (for ECR Pull).
- [ ] Target Group Health Checks are "Healthy".
- [ ] ALB Listener Rules match the hyphenated host header.
- [ ] API Gateway Custom Domains are `AVAILABLE` (not `PENDING`).
- [ ] Route 53 Alias records point to the API Gateway regional endpoints.
- [ ] `https://automation-[region].mixtelematics.com` loads the UI login screen.
- [ ] `https://automation-api-[region].mixtelematics.com/swagger/index.html` returns 200.

---

## 6. Where to Configure DNS Routing in AWS?

### Option A: API Gateway Custom Domains (Recommended — matches the proxy pattern above)
1. Go to **API Gateway -> Custom domain names**.
2. Create domains for `automation-[region].mixtelematics.com` and `automation-api-[region].mixtelematics.com`.
3. Attach the `*.mixtelematics.com` ACM certificate (ARN in AU account: `arn:aws:acm:ap-southeast-2:365528985733:certificate/720bfd98-5065-47e6-a94d-8227d72dc1ad`).
4. Map both domains to the proxy HTTP API's `$default` stage.
5. In Route 53, alias both domains to the API Gateway regional domains provided after creation.

### Option B: Route 53 Direct ALB Alias (Only if ALB is internet-facing)
1. Go to **Route 53 -> Hosted zones**.
2. Open the public `mixtelematics.com` zone.
3. Create Records with Name `automation-[region]` and `automation-api-[region]`.
4. Type: `A` -> Check **Alias** -> Route traffic to the ALB in the correct region.

### Option C: Cloudflare / External DNS
If you cannot find the wildcard `*.au` in AWS Route 53, your IT team manages `mixtelematics.com` via Cloudflare or Active Directory DNS. Submit a ticket to add CNAME records pointing to the API Gateway regional endpoint.

---

*Also lives in: [[Global_Deployment_Guide]]*
