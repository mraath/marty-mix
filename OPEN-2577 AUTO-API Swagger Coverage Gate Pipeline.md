---
wiki_ingested: false
tags: [jira, open, automation, pipeline, testing]
date: 2026-06-03
status: In Progress Dev
story_points: null
---

# OPEN-2577 — AUTO-API: Wire Swagger Coverage Gate into Azure DevOps Pipeline

**Status:** In Progress Dev  
**Jira:** https://powerfleet.atlassian.net/browse/OPEN-2577

## Goal
Add a post-deploy stage to `azure-pipelines.yml` that runs the swagger coverage gate automatically after each API deployment on INT.

## What it does
- Runs `scan-swagger.ps1 -System automation -Env INT` post-deploy
- Fails pipeline if new endpoints found without tests
- Runs read-only test suites (Health, Utility, PageLoad) against deployed env
- Publishes test results as pipeline artifact

## Dependencies
- Blocked by OPEN-2576 (swagger scanner + registry)
- Blocked by `w-automation-test-hub` skill

## Acceptance Criteria
- Pipeline stage runs automatically after API deployment
- New endpoint without test fails the pipeline
- Results visible in Azure DevOps build summary + artifact JSON
