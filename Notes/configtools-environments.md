---
created: 2026-06-23T15:28
updated: 2026-06-23T15:55
---
# ConfigTools — All Environments

> Updated: 2026-06-23
> UAT excluded — ECR repos still missing. 6 live prod envs.

## Live Environments

| Env | UI | API | Swagger |
|-----|----|----|---------|
| INT | configtools.mixdevelopment.com | configtools-api.mixdevelopment.com | /swagger/index.html |
| AU | configtools.au.mixtelematics.com | configtools-api.au.mixtelematics.com | /swagger/index.html |
| ZA | configtools.za.mixtelematics.com | configtools-api.za.mixtelematics.com | /swagger/index.html |
| UK | configtools.uk.mixtelematics.com | configtools-api.uk.mixtelematics.com | /swagger/index.html |
| US | configtools.us.mixtelematics.com | configtools-api.us.mixtelematics.com | /swagger/index.html |
| ENT | configtools.ent.mixtelematics.com | configtools-api.ent.mixtelematics.com | /swagger/index.html |
| UAE | configtools.ae.mixtelematics.com | configtools-api.ae.mixtelematics.com | /swagger/index.html |
| UAT | configtools.uat.mixtelematics.com | configtools-api.uat.mixtelematics.com | excluded |

## Key Notes

- **UAE uses `ae.`** — NOT `uae.`. Applies everywhere: subdomain, ECS service names, Route53 records, ALB listener rules.
- **UAT excluded from smoke tests** — ECR repos still missing as of 2026-06-23. Do not include in prod pipeline until ECR set up.
- **VPN breaks prod URLs** — these are public `*.mixtelematics.com` URLs. Turn VPN off before testing.
- All 6 live envs are Ready for QA (deployed 2026-06-19 to 2026-06-22).

## Related

- Test hub environments.json: `C:\Projects\SDLC\.agent\skills\w-automation-test-hub\systems\configtools\environments.json`
- Gap analysis + test plan: [[configtools-test-gap-analysis-2026-06-22]]
- Appsettings audit: [[appsettings-audit-2026-06-22]]
