---
wiki_ingested: false
tags: [jira, open, automation, playwright, testing]
date: 2026-06-03
status: Authoring
story_points: null
---

# OPEN-2580 — AUTO-UI: Build Playwright E2E Page-Level HTML Test Runner

**Status:** Authoring  
**Jira:** https://powerfleet.atlassian.net/browse/OPEN-2580

## Goal
HTML page that runs Playwright E2E tests per UI page — quick checks that run in the pipeline after UI deployment.

## What it does
- Lists all UI pages (Config Delta, Config Compare, QC, Decomm, Salesforce, etc.)
- Per-page Run button triggers Playwright test for that page
- Pass/fail status + screenshot + error on failure
- Environment selector for target URL
- Run All button (sequential)
- Results exportable as JSON

## Out of scope
- Azure DevOps pipeline integration (story 3b — separate)
- Per-story scenario tests (OPEN-2582)

## Dependencies
- Blocked by `w-automation-test-hub` (Playwright dir structure exists, not yet implemented)

## Test safety contract
- No permanent DB changes
- Verify page loads + basic element presence + primary action button works
