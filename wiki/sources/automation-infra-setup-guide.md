---
type: source
title: Automation Infrastructure Setup Guide
date_ingested: 2026-05-28
original_file: Automation Infrastructure Setup Guide.md
---

## Summary

Reference guide documenting the AWS infrastructure components for Powerfleet.Automation (DEV/INT/PROD). Covers ECS cluster naming, ALB setup, environment variables (`ASPNETCORE_ENVIRONMENT`), PowerShell verification scripts, and connectivity testing URLs. Created 2026-02-16, updated 2026-03-05.

## Key Takeaways

- ECS cluster/service naming: `{ENV}-Config` cluster, `{env}-powerfleet-automation-ui/api` services
- **Critical**: `ASPNETCORE_ENVIRONMENT` defaults to `Production` if not set — causes 500 errors in non-prod
- Standard healthcheck: `http://automation-api.{env}.mixtelematics.com/health`
- AWSPowerShell module `Get-ECSService` for service status verification

## Wiki Pages Updated

- [[Powerfleet-Automation-AWS]] — component names and env vars
- [[AWS-Deployment-Pattern]] — verification checklist
