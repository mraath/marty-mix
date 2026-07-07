---
created: 2026-05-21
wiki_ingested: 2026-05-28
updated: 2026-07-07
---
# Automation UI URLs

> **⚠️ "UAE" vs "AE" — the actual code/pipeline short code is `AE`, not `UAE`.** This table's row label "UAE" is a human-readable region name (United Arab Emirates), but every `environments.json`, pipeline `TargetEnvOverride` parameter, and `case`/`switch` statement across both Powerfleet.Automation and ConfigTools uses the literal string `AE`. Confirmed 2026-07-07 while running a manual pipeline sweep (config@mixtel.com credential migration verification) — using `UAE` as a `TargetEnvOverride` value causes either an outright `Unknown TargetEnv: UAE` failure (Powerfleet.Automation.UI's `playwright-tests.yml`) or a silent misroute into unrelated pipeline logic (Powerfleet.Automation's `api-tests.yml`). **When writing any script, pipeline parameter, or manual queue that targets this environment, always use `AE`.**

| Env | UI URL | API URL | API Swagger |
|-----|--------|---------|-------------|
| DEV | — | — | — (`*.dev.mixtelematics.com`, no swagger URL recorded) |
| INT | [https://automation.mixdevelopment.com](https://automation.mixdevelopment.com) | [https://automation-api.mixdevelopment.com](https://automation-api.mixdevelopment.com) | [https://automation-api.mixdevelopment.com/swagger/index.html](https://automation-api.mixdevelopment.com/swagger/index.html) |
| AU | [https://automation-au.mixtelematics.com](https://automation-au.mixtelematics.com) | [https://automation-api-au.mixtelematics.com](https://automation-api-au.mixtelematics.com) | [https://automation-api-au.mixtelematics.com/swagger/index.html](https://automation-api-au.mixtelematics.com/swagger/index.html) |
| ZA | [https://automation.za.mixtelematics.com](https://automation.za.mixtelematics.com) | [https://automation-api.za.mixtelematics.com](https://automation-api.za.mixtelematics.com) | [https://automation-api.za.mixtelematics.com/swagger/index.html](https://automation-api.za.mixtelematics.com/swagger/index.html) |
| UK | [https://automation.uk.mixtelematics.com](https://automation.uk.mixtelematics.com) | [https://automation-api.uk.mixtelematics.com](https://automation-api.uk.mixtelematics.com) | [https://automation-api.uk.mixtelematics.com/swagger/index.html](https://automation-api.uk.mixtelematics.com/swagger/index.html) |
| US | [https://automation.us.mixtelematics.com](https://automation.us.mixtelematics.com) | [https://automation-api.us.mixtelematics.com](https://automation-api.us.mixtelematics.com) | [https://automation-api.us.mixtelematics.com/swagger/index.html](https://automation-api.us.mixtelematics.com/swagger/index.html) |
| ENT | [https://automation.ent.mixtelematics.com](https://automation.ent.mixtelematics.com) | [https://automation-api.ent.mixtelematics.com](https://automation-api.ent.mixtelematics.com) | — (not recorded in skill reference) |
| UAT | [https://automation.uat.mixtelematics.com](https://automation.uat.mixtelematics.com) | [https://automation-api.uat.mixtelematics.com](https://automation-api.uat.mixtelematics.com) | [https://automation-api.uat.mixtelematics.com/swagger/index.html](https://automation-api.uat.mixtelematics.com/swagger/index.html) |
| UAE | [https://automation.ae.mixtelematics.com](https://automation.ae.mixtelematics.com) | [https://automation-api.ae.mixtelematics.com](https://automation-api.ae.mixtelematics.com) | [https://automation-api.ae.mixtelematics.com/swagger/index.html](https://automation-api.ae.mixtelematics.com/swagger/index.html) |
| ZAGOV | [https://automation-zagov.powerfleet.com](https://automation-zagov.powerfleet.com) | [https://automation-api-zagov.powerfleet.com](https://automation-api-zagov.powerfleet.com) | [https://automation-api-zagov.powerfleet.com/swagger/index.html](https://automation-api-zagov.powerfleet.com/swagger/index.html) |

> **AU is the one environment that breaks the dot pattern** — uses `automation-au` (hyphen) rather than `automation.au` (dot). Confirmed root cause of a false "AU outage" (OPEN-3075, 2026-07-06): a pipeline hardcoded the wrong dot-form URL, which 503s because it was never valid — the real hyphen-form URL was healthy the whole time. **ConfigTools does NOT share this exception** — ConfigTools AU uses the dot form (`configtools.au...`), see [[ConfigTools URLs]].
> **INT** is on the `mixdevelopment.com` domain, not `mixtelematics.com`.
> **ZAGOV** is on the `powerfleet.com` domain (single-level cert) — uses hyphen form like AU, but for a different reason (ZAGOV's ACM cert only covers one subdomain level of `*.powerfleet.com`).
> All other envs (ZA/UK/US/ENT/UAT/AE) follow `automation.{env}.mixtelematics.com` / `automation-api.{env}.mixtelematics.com`.
> **Domain naming rule (source: `.agent/skills/aws-regional-deployment/SKILL.md`):** the company's `*.mixtelematics.com` wildcard cert only covers one subdomain level — any hostname needing a second level (like `automation.au.mixtelematics.com`, which is two levels: `au` and `mixtelematics`) must use a hyphen instead of a dot to stay within that cert's coverage. This is *why* AU (and ZAGOV, on a different cert) are hyphenated while single-level envs (`za`, `uk`, etc.) aren't.
> **Discrepancy note:** `w-automation-test-hub/systems/automation/environments.json` (a separate, non-authoritative cache) shows ZA/ENT/US/UK/AE UI URLs in hyphen form — this table uses the `aws-regional-deployment` skill's explicit, reasoned domain-naming rule as the authority instead, since that skill documents *why* each env is dot vs. hyphen. If a URL here 404s, treat that as the file needing a refresh, not this table being wrong.

## AWS Account / Region per Environment

| Env | Region | AWS Account ID | Cluster |
|-----|--------|-----------------|---------|
| DEV | eu-west-1 | 601704920959 | DEV-Config |
| INT | eu-west-1 | 601704920959 | INT-Config |
| AU | ap-southeast-2 | 365528985733 | AU-Config |
| ZA | eu-west-1 | 668736068906 | ZA-Config |
| UK | eu-west-1 | 365528985733 | UK-Config |
| US | us-east-1 | 365528985733 | US-Config |
| UAT | eu-west-1 | 059521945538 | UAT-Config |
| UAE | ap-south-1 | 365528985733 | UAE-Config |
| ZAGOV | af-south-1 | 120736098406 | ZAGOV-Config |

Source: `.agent/skills/aws-regional-deployment/SKILL.md` — same file for full deployment steps (ECS, ALB, Route 53, ECR) if standing up a new environment.
