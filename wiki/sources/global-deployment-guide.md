---
type: source
title: Global Deployment Guide — Powerfleet Automation
date_ingested: 2026-05-28
original_file: Global_Deployment_Guide.md
---

## Summary

Step-by-step guide for deploying Powerfleet.Automation to any new AWS region. Covers all 4 infrastructure components (Target Groups, ALB Listener Rules, Task Definitions, ECS Services), the mandatory URL hyphen convention, the API Gateway HTTP Proxy pattern for private ALBs, and DNS/Route 53 configuration options. Created 2026-03-04.

## Key Takeaways

- URL convention is MANDATORY — wildcard cert won't cover dot-notation subdomains
- API Gateway proxy needed when ALB is private (AU pattern) — includes 40-min TLS propagation delay
- `overwrite:header.host` parameter mapping is CRITICAL for ALB listener rule matching
- Three DNS options: API Gateway Custom Domains (recommended), Direct ALB alias, Cloudflare/external DNS

## Wiki Pages Updated

- [[AWS-Deployment-Pattern]] — primary deployment pattern concept
- [[Powerfleet-Automation-AWS]] — URL naming rule and API GW pattern
