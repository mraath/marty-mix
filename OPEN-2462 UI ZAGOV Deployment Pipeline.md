---
wiki_ingested: false
tags: [jira, open, automation, pipeline, zagov]
date: 2026-06-03
status: On Hold
story_points: null
---

# OPEN-2462 — UI: Add Deployment Pipeline to ZAGOV Environment

**Status:** On Hold ⏸  
**Jira:** https://powerfleet.atlassian.net/browse/OPEN-2462

## Goal
Azure DevOps deployment pipeline for `Powerfleet.Automation.UI` → ZAGOV, mirroring UAE (OPEN-2426) and UAT (OPEN-2427).

## Key facts
- Triggers on merge `integration` → `production`
- Failure notification → Operations Tools Teams channel
- Manual approval gate TBC
- Rollback is manual

## Dependencies
- Related: OPEN-2426 (UAE pipeline — reference impl)
- Related: OPEN-2427 (UAT pipeline — reference impl)
- Related: OPEN-1996 (add ZAGOV to login screen environment dropdown — do after this)
- Blocked by: OPEN-2461 (API pipeline must exist first)

## Blocked because
Same as OPEN-2461 — ZAGOV AWS infra on hold.
