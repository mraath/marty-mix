---
type: source
title: ZAGOV — Powerfleet Automation Deployment
date_ingested: 2026-05-28
original_file: Notes/ZAGOV-AWS-Deployment.md
---

## Summary

Complete infrastructure reference for the ZAGOV (ZA Government) Powerfleet.Automation deployment. Covers account `120736098406` in `af-south-1` (Cape Town), all networking/ECS/ECR/IAM resources, Aurora PostgreSQL setup, CI/CD pipeline state, and the critical `appsettings.ZAGOV.json` case-sensitivity bug. Created 2026-05-25.

## Key Takeaways

- ZAGOV uses `powerfleet.com` domain, not `mixtelematics.com`
- Auth is Microsoft Entra ID (IAM Identity Center) — `saml2aws` doesn't work, manual portal creds required every ~1h
- Pipeline is manual-only with `ForceDeployZAGOV = true` parameter
- **Case bug**: `appsettings.zagov.json` silently falls back to `appsettings.json` (DEV URLs) on Linux — must be `appsettings.ZAGOV.json`
- Aurora PostgreSQL provisioned 2026-05-26; `001_configdiff_postgresql.sql` migration applied ✅
- DNS A-alias records still outstanding — `powerfleet.com` zone owner unknown

## Wiki Pages Created

- [[ZAGOV-Environment]] — entity created

## Wiki Pages Updated

- [[AWS-Environments]] — ZAGOV account added
- [[Powerfleet-Automation-AWS]] — ZAGOV case-sensitivity bug noted
