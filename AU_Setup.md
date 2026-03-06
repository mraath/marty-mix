---
created: 2026-03-04T09:49
updated: 2026-03-06T10:50
---
# AU Infrastructure Setup & Troubleshooting Guide

This document maintains a living record of the steps taken to troubleshoot, fix, and mirror the `au-powerfleet-automation-ui` and `au-powerfleet-automation-api` services in the AU environment, based on exactly what works in DEV.

## 🟢 1. What We Upgraded/Fixed So Far
1. **ECR Image URIs Fixed**: Both services now pull from `365528985733.dkr.ecr.ap-southeast-2.amazonaws.com` instead of the cross-region DEV (`eu-west-1`) account.
2. **Security Group Egress Fixed (CRITICAL)**: The ECS Security Group `sg-09d97cfc127d25b95` was completely lacking outbound internet access. An `All Traffic` rule was added so ECS Fargate could reach the NAT Gateway to pull ECR images. 
3. **Subnet Alignment Fixed**: ECS Services restricted strictly to the two AZs used by the `AU-Config-InternalALB` (`ap-southeast-2a` and `ap-southeast-2b`).
4. **Clean Deployment Status**: Both ECS Services are successfully running tasks (`ACTIVE` and reaching steady-state). The containers themselves are healthy.

## 🟢 2. Public Access Solution: API Gateway Proxy
Instead of struggling with corporate DNS wildcard hijacking (`*.au`), we implemented a cloud-native proxy using **AWS API Gateway (HTTP)**.

1. **Invoke URL**: `https://oroqo28ut0.execute-api.ap-southeast-2.amazonaws.com`
2. **VPC Link**: `53iyqq` (Connects the public API to the private AU VPC).
3. **Integration**: Connects to `AU-Config-InternalALB` on HTTP:80.
4. **Parameter Mapping (CRITICAL)**: Overwrites the `Host` header to `automation.au.mixtelematics.com`. This is necessary because the Internal ALB rejects traffic if the host header doesn't match its listener rules.

## 🛠️ 3. Scripts We Are Actively Using
* `c:\Projects\Powerfleet.Automation\deep_check.py`: Dumps exact container statuses and IPs.
* `c:\Projects\Powerfleet.Automation\apply_mapping.py`: (NEW) CLI script to apply Host-header mapping to API Gateway.

## ✅ Final Result: Steady State
The AU environment is now **fully functional and publicly accessible**. UI and API services are healthy, and traffic is flowing correctly through the API Gateway -> VPC Link -> Internal ALB -> ECS Tasks.
