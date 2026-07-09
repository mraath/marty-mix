---
wiki_ingested: 2026-05-28
created: 2025-03-06T16:42
updated: 2025-04-17T10:31
---

## Newer


- Usually on the server hosting on L$ as .log files
- Logz.io (discontinued)
- [Axiom](https://app.axiom.co/ "https://app.axiom.co/")
	- Sign in and then select "Continue with SAML" and the "slug" to enter is "powerfleet" -- all lowercase
	- Workspace path for saved queries: `app.axiom.co/powerfleet-cpve/...`
	- **Filtering to the 4 Axiom-migrated Ops Tools apps** (Powerfleet.Automation, ConfigTools.API, Powerfleet.Analyzer, SupportTools — added 2026-07): the field is `ApplicationName` (not `AppName`), values are `Powerfleet.Automation.Api`, `ConfigTools.API.Api`, `Powerfleet.Analyzer.Api`, `SupportTools.Api`. Dataset per env tier: `int-logs` (DEV+INT), `uat-logs` (UAT), `prod-logs` (everything else). Query:
		```
		['int-logs']
		| where ApplicationName in ('Powerfleet.Automation.Api', 'ConfigTools.API.Api', 'Powerfleet.Analyzer.Api', 'SupportTools.Api')
		| sort by _time desc
		| limit 100
		```
		All 4 apps log automatically on startup (no request needed) — check shortly after running each one. If not immediately visible, wait ~30-40 min and re-check; the periodic `LOGFILE cleanup starting` message is a reliable secondary confirmation signal even if you miss the one-time startup line. Confirmed live 2026-07-09: all 4 apps (Automation, ConfigTools.API, Analyzer, SupportTools) verified logging to `int-logs` on INT.
	- Correct field name (confirmed via live query, corrects an earlier guess): `appName` (lowercase, not `ApplicationName`).

## OLDER

When setting up a log I usually go to:
[[Logz.io]] to something already set up like this:
[eg Logz.io](https://app.logz.io/#/goto/eb810565fb1757b4034f0b19bbccc24f?switchToAccountId=157279)
I then ensure the Env is set eg. INT
Then the date range
Then message is one of "value" "value2"
Once happy, I select the part of the time bar I want to share
I then hit share
Copy link
Paste that into my Jira or Note or Team

Once passed on INT you can reuse this LOG for PROD
Just adjust eg. Env, MobileUnitId, etc




