# OPEN-2936 — Enable Tier 1/2/3 API Tests Against All Prod Environments Post-Deploy

> Status: ✅ Infrastructure complete (2026-06-29)

## What Was Done

All 3 repos changed and merged (integration + production branches):
- ConfigTools.API — PRs #148911 (int) / #148914 (prod)
- Powerfleet.Automation — PRs #148912 (int) / #148915 (prod)
- Powerfleet.Automation.UI — PRs #148913, #148919 (int) / #148916, #148920 (prod)

All deployments succeeded: AU, ZA, ENT, UK, US, UAT, UAE for all 3 repos.

## Root Cause Investigation (2026-06-29)

### Problem 1 — Old resource trigger runs had empty TargetEnv
Runs at 02:20, 02:41, 03:11 on 06/29 had empty `TargetEnvOverride`. These fired from the OLD resource trigger (`trigger: pipeline`) before `trigger: none` was merged. One-time artifact — no further action.

### Problem 2 — ADO definition-level CI trigger overriding `trigger: none`
**Pipelines 2510 and 2511 both had a CI trigger baked into their ADO build definitions that overrode the YAML's `trigger: none`.**

Symptom: every commit to Powerfleet.Automation/integration fired a duplicate empty-TargetEnv test run alongside the trigger_tests-queued run (paired runs at 04:19/04:24 and 04:32/04:33).

Fix: cleared CI trigger via REST API PUT — 2510 (rev 7→8), 2511 (rev 8→9).

### Problem 3 — SDLC git clone 429 (already fixed)
Multiple simultaneous test runs all cloned SDLC → HTTP 429 rate limit. Fixed in PR 149062: replaced git clone with REST API individual file fetch ("Fetch SDLC scripts" PowerShell step).

## trigger_tests Stage — Confirmed Working
The 06/28 23:52 batch shows all 8 environments correctly queued with proper `TargetEnvOverride` (AU/US succeeded on 2511; others failed due to old SDLC clone issue which is now fixed).

## PR Conflict Resolution (2026-06-29)

PRs #149105 (ConfigTools.API) and #149104 (Powerfleet.Automation) had conflicts against integration.

**Root cause:** Integration had moved forward with ~10 OPEN-2936 commits touching the same `api-tests.yml`. The fix branch (HEAD) had the correct runtime bash TargetEnv resolution but still used the old `git clone` for SDLC. Integration had the PowerShell REST fetch fix but the broken compile-time `${{ }}` template expression for TargetEnv.

**Resolution applied to both files:**
- Variables block: kept HEAD comment only — dropped integration's `${{ if/else }}` with `variables['resources.pipeline.*.stageName']` (compile-time expressions can't read runtime `stageName`)
- 3 job blocks each: kept HEAD's bash "Resolve TargetEnv" step + took integration's PowerShell REST "Fetch SDLC scripts" task; dropped the `git clone` (causes 429 rate limits when parallel builds run)

Both branches pushed; both PRs now `mergeStatus=succeeded`. Ready to merge.

## Verify Next
Trigger an integration deploy and confirm exactly ONE test run fires per env with populated `TargetEnvOverride=INT`.
