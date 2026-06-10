---
wiki_ingested: false
tags: [jira, open, configtools, pipeline, done]
date: 2026-06-03
status: Done
story_points: null
---

# OPEN-2574 — CT-UI: Deploy ConfigTools.UI to INT Environment

**Status:** Done ✅  
**Jira:** https://powerfleet.atlassian.net/browse/OPEN-2574

## What was done
- Azure DevOps release pipeline created for ConfigTools.UI → INT
- Env config file added with INT API base URL pointing to CT-API INT instance
- Deploys from `integration` branch (manual trigger)
- INT UI loads without console errors, reaches `/health` endpoint
- Secrets via Azure DevOps variable groups

## Dependencies
- Blocked by OPEN-2573 (CT-API INT must exist first)

## Notes
- Reference: Powerfleet.Automation.UI INT pipeline in OperationsTools project
