---
type: source
title: AU Powerfleet Automation Setup Summary + Infrastructure Audit
date_ingested: 2026-05-28
original_file: AU-Automation-Setup-Summary.md + au_infrastructure_audit_and_fixes.md
---

## Summary

Combined source covering the AU (Sydney, ap-southeast-2) deployment success story and the subsequent infrastructure audit. Two major problems were solved: (1) corporate DNS wildcard hijacking requiring API Gateway proxy, (2) `*.mixtelematics.com` wildcard not covering two-level subdomains requiring hyphenated domain format. The audit found and fixed 4 issues: cross-region ECR URIs, missing SG outbound rules, subnet misalignment, and ECS Circuit Breaker loop.

## Key Takeaways

- API GW ID `oroqo28ut0`, VPC Link `53iyqq` — AU-specific resources
- ACM cert ARN: `arn:aws:acm:ap-southeast-2:365528985733:certificate/720bfd98-5065-47e6-a94d-8227d72dc1ad`
- Missing SG outbound rule = `ResourceInitializationError: i/o timeout` on ECR pull
- Cross-region ECR URI = tasks pull old DEV images despite new AU pipeline
- Audit scripts created: `audit_au.py`, `check_status.py`, `clean_deploy.py` in `C:\Projects\Powerfleet.Automation`
- `saml2aws login --role arn:aws:iam::365528985733:role/MiX-DevOpsAdmin` for AU auth

## Wiki Pages Updated

- [[Powerfleet-Automation-AWS]] — AU resources, Python env note, failure modes
- [[AWS-Deployment-Pattern]] — failure modes table enriched
