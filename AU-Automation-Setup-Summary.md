---
created: 2026-03-04T11:13
updated: 2026-03-04T15:22
tags:
  - aws
  - ecs
  - apigateway
  - ssl
  - deploy
  - au
status: done
---

# AU Powerfleet Automation Setup Summary

**Date**: 2026-03-04
**Project**: [[Powerfleet.Automation]]
**Ticket**: [[OPEN-1715 Setup UI and API on AWS for AU]]

## 🟢 Summary of Success

The AU deployment of Powerfleet Automation (UI & API) is now fully operational and publicly accessible via:
- **UI**: `https://automation-au.mixtelematics.com`
- **API**: `https://automation-api-au.mixtelematics.com`

We overcame two major blockers: a DNS routing restriction and an SSL wildcard certificate limitation.

---

## 🛠️ Challenge 1: DNS Hijacking / Private ALB

We discovered that corporate DNS wildcard records (`*.au.mixtelematics.com`) were forcibly hijacking traffic intended for our Application Load Balancer. Direct Route 53 CNAMEs were being swallowed, preventing external access to the healthy ECS containers. The AU Internal ALB (`AU-Config-InternalALB`) is completely private and not reachable from the public internet directly.

### Solution: API Gateway HTTP Proxy

To bridge the public internet to the private internal ALB, we implemented an **AWS API Gateway (HTTP)** proxy layer.

**Architecture:**
1. **Public Entry Point**: An HTTP API (`AU-Powerfleet-Automation-Proxy`, API ID: `oroqo28ut0`) provides a predictable AWS-provided invoke URL.
2. **Private Bridge**: A **VPC Link** (`ID: 53iyqq`) was established to allow the gateway to communicate with private resources in the AU VPC (`vpc-1553a770`).
3. **Internal ALB Integration**: The gateway uses a private integration to forward traffic to the `AU-Config-InternalALB` on Port 80 via the VPC Link.
4. **Host Header Mapping (CRITICAL)**: The Internal ALB has strictly defined listener rules matching on the `host-header`. Since API Gateway uses its own hostname by default, the ALB would reject the traffic. We applied a **Parameter Mapping** to overwrite the `Host` header:
   - **Parameter**: `overwrite:header.host`
   - **Value**: `automation-au.mixtelematics.com`
5. **Catch-all Route**: A single `$default` route forwards all traffic to the integration.

---

## 🔒 Challenge 2: SSL Wildcard Certificate Limitation

During proxy setup, we initially mapped `automation.au.mixtelematics.com` using the company's `*.mixtelematics.com` wildcard certificate. The browser UI proxy in the Next.js container immediately failed with:

```
ERR_TLS_CERT_ALTNAME_INVALID
Host: automation-api.au.mixtelematics.com is not in the cert's altnames: DNS:*.mixtelematics.com
```

**The Rule**: A standard wildcard certificate (e.g., `*.mixtelematics.com`) only covers **one subdomain level**.
- ✅ Covered: `automation.mixtelematics.com`, `api.mixtelematics.com`
- ❌ NOT Covered: `automation.au.mixtelematics.com`, `automation-api.au.mixtelematics.com`

### Solution: Hyphenated Domains

To use the existing `*.mixtelematics.com` wildcard certificate (ACM ARN: `arn:aws:acm:ap-southeast-2:365528985733:certificate/720bfd98-5065-47e6-a94d-8227d72dc1ad`) without raising a new certificate request with IT, the domain format was changed to a **single-level subdomain using hyphens**:

| Old (broken) | New (working) |
|---|---|
| `automation.au.mixtelematics.com` | `automation-au.mixtelematics.com` |
| `automation-api.au.mixtelematics.com` | `automation-api-au.mixtelematics.com` |

**Changes that were applied:**
1. **`api-urls.ts`** (UI code): Updated the `au` environment entry to reference the hyphenated API base URLs.
2. **API Gateway Custom Domain Names**: Created new Custom Domain Names for both hyphenated domains, attached to the `*.mixtelematics.com` ACM certificate.
3. **API Gateway Mappings**: Mapped both custom domains to the `$default` stage of `AU-Powerfleet-Automation-Proxy`.
4. **Route 53**: Upserted `A (Alias)` records for both hyphenated domains pointing to their respective API Gateway regional endpoints:
   - `automation-au` → `d-ry5d00gxbh.execute-api.ap-southeast-2.amazonaws.com`
   - `automation-api-au` → `d-y4iokqixk2.execute-api.ap-southeast-2.amazonaws.com`
5. **ALB Listener Rules**: Updated the internal ALB `host-header` conditions from the dot-notation to the hyphenated format.

> [!NOTE]
> After creating a new API Gateway Custom Domain with a new certificate, AWS can take **up to 40 minutes** to fully propagate the TLS configuration. You may see an `InternalError` TLS alert during this window — this is normal and resolves on its own.

---

## 🔗 Key AWS Resources

| Resource | Value |
|---|---|
| UI Public URL | `https://automation-au.mixtelematics.com` |
| API Public URL | `https://automation-api-au.mixtelematics.com` |
| API Gateway (raw) | `https://oroqo28ut0.execute-api.ap-southeast-2.amazonaws.com` |
| API Gateway ID | `oroqo28ut0` |
| Integration ID | `zfwfhpc` |
| Internal ALB | `AU-Config-InternalALB` |
| ECS Cluster | `AU-Config` |
| VPC Link ID | `53iyqq` |
| SSL Cert ARN | `arn:aws:acm:ap-southeast-2:365528985733:certificate/720bfd98-5065-47e6-a94d-8227d72dc1ad` |
| AWS Account | `365528985733` |
| Region | `ap-southeast-2` (Sydney) |

---

## 📋 Final Request Flow

```
Browser → https://automation-au.mixtelematics.com
           ↓
      Route 53 (A Alias)
           ↓
      API Gateway Custom Domain (*.mixtelematics.com cert terminates TLS)
           ↓
      API Gateway $default route → Private Integration
           ↓ (rewrites Host header to automation-au.mixtelematics.com)
      VPC Link → Internal ALB (Port 80)
           ↓ (host-header matches automation-au.mixtelematics.com rule)
      ECS Fargate Target Group (Port 3000)
           ↓
      Next.js UI Container
```

---

## 📖 Related Docs
- [[Global_Deployment_Guide]] (Updated with SSL rules and hyphenated URL requirement)
- [[AU_Setup]] (Updated with AU-specific ingress details)
