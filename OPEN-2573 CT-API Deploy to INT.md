---
wiki_ingested: false
tags: [jira, open, configtools, pipeline, done]
date: 2026-06-03
status: Done
story_points: null
---

# OPEN-2573 — CT-API: Deploy ConfigTools.API to INT Environment

**Status:** Done ✅  
**Jira:** https://powerfleet.atlassian.net/browse/OPEN-2573

## What was done
- Azure DevOps release pipeline created for ConfigTools.API → INT
- `appsettings.INT.json` added to `ConfigTools.API.Api`
- Deploys from `integration` branch (manual trigger)
- `/health` endpoint passes post-deploy
- Secrets via Azure DevOps variable groups (not hardcoded)

## Notes
- Reference pipeline: Powerfleet.Automation INT pipeline in OperationsTools project
- INT DB connection strings confirmed with team before implementation
