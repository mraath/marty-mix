---
created: 2026-03-04T11:13
updated: 2026-03-04T11:13
---
# AU Powerfleet Automation Setup Summary

**Date**: 2026-03-04
**Project**: [[Powerfleet.Automation]]
**Ticket**: [[OPEN-1715 Setup UI and API on AWS for AU]]

## 🟢 Summary of Success
The AU deployment of Powerfleet Automation (UI & API) is now fully operational and publicly accessible. We successfully bypassed a major environmental blocker using a cloud-native ingress pattern.

## 🛠️ The Core Challenge: DNS Hijacking
We discovered that corporate DNS wildcard records (`*.au.mixtelematics.com`) were forcibly hijacking traffic intended for our Application Load Balancer. Direct Route 53 CNAMEs were being swallowed, preventing external access to the healthy ECS containers.

## 🚀 The Solution: API Gateway Proxy
To bypass the DNS hijacking, we implemented an **AWS API Gateway (HTTP)** proxy layer.

### Architecture Highlights:
1. **Public Entry Point**: An HTTP API (`AU-Powerfleet-Automation-Proxy`) provides a predictable AWS-provided URL.
2. **Private Bridge**: A **VPC Link** was established to allow the gateway to communicate with private resources in the AU VPC (`vpc-1553a770`).
3. **Internal ALB Integration**: The gateway forwards traffic to the `Internal-AU-Config-InternalALB` on Port 80.
4. **Host Header Mapping (Critical Fix)**: 
   - Since the Internal ALB is configured with strictly defined listener rules (expecting `automation.au...`), it was rejecting requests from the API Gateway which used its own hostname.
   - We applied a **Parameter Mapping** to overwrite the `Host` header to `automation.au.mixtelematics.com`. This "tricks" the ALB into recognizing the traffic.

## 🔗 Key Links & Resources
- **Invoke URL**: `https://oroqo28ut0.execute-api.ap-southeast-2.amazonaws.com`
- **Internal ALB**: `AU-Config-InternalALB`
- **ECS Cluster**: `AU-Config`
- **VPC Link ID**: `53iyqq`

## 📖 Related Docs
- [[Global_Deployment_Guide]] (Updated with Step 6: Public Access Proxy)
- [[AU_Setup]] (Updated with AU-specific ingress details)
