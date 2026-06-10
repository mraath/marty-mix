---
wiki_ingested: false
tags: [jira, open, automation, pipeline, zagov]
date: 2026-06-03
status: On Hold
story_points: null
---

# OPEN-2461 — API: Add Deployment Pipeline to ZAGOV Environment

**Status:** On Hold ⏸  
**Jira:** https://powerfleet.atlassian.net/browse/OPEN-2461

## Goal
Azure DevOps deployment pipeline for `Powerfleet.Automation` → ZAGOV, mirroring UAE (OPEN-2424) and UAT (OPEN-2425).

## Key facts
- Triggers on merge `integration` → `production`
- Failure notification → Operations Tools Teams channel
- Manual approval gate TBC
- Rollback is manual

## Dependencies
- Related: OPEN-2424 (UAE pipeline — reference impl)
- Related: OPEN-2425 (UAT pipeline — reference impl)
- ZAGOV AWS infra provisioned (OPEN-2461 is pipeline only)

## Blocked because
ZAGOV AWS infra + pipeline work was put on hold — unblocks when AWS ZAGOV is ready.

## ZAGOV specifics (from prior work)
- Account: `120736098406`, region `af-south-1`
- Auth: Microsoft-federated AWS IAM Identity Center (~1h credentials)
- Aurora PostgreSQL: `mix-zagov-aurpg01`
