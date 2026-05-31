---
type: source
title: Operations Tools — Master Reference
date_ingested: 2026-05-28
original_file: Operations Tools.md
---

## Summary

The master Operations Tools note tracks all active sprint tickets, AWS environments, engineering directives from the boss (March 2026), completed stories, and the full roadmap. It is a living document updated to 2026-05-28. Marthinus Raath is the primary engineer on Config Delta / Audit Tool and AWS deployments. Cornel Coetzee owns Salesforce integration. The team has two production AWS environments (AU, ZA) and two pipelines-done-but-infra-pending environments (ENT, ZAGOV).

## Key Takeaways

- **6 active tickets assigned to Marthinus:** OPEN-2360, OPEN-2361, OPEN-2362, OPEN-2363, OPEN-2461 (On Hold), OPEN-2462 (On Hold)
- **Boss directives:** Data via API, UI via agents, well-commented code, agents can commit/PR (humans approve)
- **ZA prod cert note:** `*.mixtelematics.com` cert in ZA AWS account is expired — only `*.za.mixtelematics.com` works
- **S3 → DB persistence:** OPEN-2029 shipped and confirmed — no more runtime file loss on ECS restart
- **ENT:** CI/CD pipelines done; AWS infra (ECS, ALB, DNS) still needs setup — ticket needed
- **OPEN-1971 (Paperclip):** Cancelled

## New Entities/Concepts

- [[Ops-Tools]] — entity created
- [[Config-Delta-Tool]] — concept created
- [[QC-Automation]] — concept created

## Wiki Pages Updated

- [[Ops-Tools]] — full sprint, roadmap, environments, directives added
