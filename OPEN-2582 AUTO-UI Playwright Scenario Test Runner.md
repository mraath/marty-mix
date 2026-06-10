---
wiki_ingested: false
tags: [jira, open, automation, playwright, testing]
date: 2026-06-03
status: Authoring
story_points: null
---

# OPEN-2582 — AUTO-UI: Build Playwright Per-Story Scenario HTML Test Runner

**Status:** Authoring  
**Jira:** https://powerfleet.atlassian.net/browse/OPEN-2582

## Goal
HTML page that runs full Playwright scenario tests per user story (e.g. "create config diff case → generate diff → verify results → delete case").

## What it does
- Lists all scenario tests grouped by user story
- Per-scenario Run button → step-level pass/fail + screenshot on failure
- Environment selector
- Run All Scenarios (long-running)
- Results exportable as JSON
- Scenarios generated from integration map + React component source

## Dependencies
- Blocked by OPEN-2580 (Playwright infrastructure)
- Blocked by OPEN-2578 (integration map for scenario generation)

## Generation flow
Read integration map + React source → Claude generates `.spec.ts` files

## Test safety contract
- No permanent DB changes
- Each scenario maps to a user story's acceptance cases
