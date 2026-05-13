# OPEN-2320 — Config Delta Fix Log

**Period:** 5–6 May 2026  
**Component:** Powerfleet.Automation.UI — Config Delta Tool  
**Environments affected:** INT, AU, ZA, ENT

---

## Background

The Config Delta Tool allows users to create "test cases" that compare a fleet of asset configs against a standard template, highlighting drift. A series of issues surfaced in this area following a UI Design branch merge that inadvertently stripped functionality.

---

## Issues Fixed

### 1. Integration branch broken by bad merges
**When:** 5 May (afternoon)

Two PRs merged to `integration` earlier that day had introduced conflicts that broke the Config Delta screen. The `Config/MR/Hotfix/OPEN-2320_ConfigDeltaRetryAndStandardFileFix` hotfix branch also contained two commits — one safe, one risky — making it unsafe to merge wholesale.

**Fix:** Reverted the two bad merge commits from `integration` using `git revert -m 1`. The safe fix was isolated and applied cleanly via cherry-pick.

---

### 2. "generate-diff.js ran but diff.json was not produced" — AU production
**When:** 5 May (emergency, before demo)

Generating a config diff for a test case with a "Custom (Asset)" standard was silently failing on AU. The generate route had a `console.warn` and continued without writing `standard.json`, causing the Node script to produce no output.

**Root cause:** `standard.json` was never written when the `__custom_standard__` asset config was not found in the database.

**Fix:** Changed `console.warn` to a proper `500` error response so the UI shows the failure instead of hanging. Cherry-picked as a minimal 2-file hotfix (`Config/MR/Hotfix/OPEN-2320_SafeErrorStateFix`) directly from `production` and deployed to AU/ZA/ENT.

---

### 3. Config Delta screen regression — custom standard picker stripped
**When:** 5 May

The UI Design branch merge (PR 144071, OPEN-1653) had removed the entire "Custom (Asset)..." standard picker from `TestCaseCreationModal`. Users could no longer select an asset as a custom standard — the option simply did not exist.

**Fix:** Restored the full custom standard picker UI in `TestCaseCreationModal.tsx`:
- Organisation → Config Group → Asset cascade picker
- State management for `customStdOrgId`, `customStdGroupIds`, `customStdAssetId`
- `canSubmit` validation requiring an asset to be selected before creating
- `__custom__` sentinel preserved in `StandardFilePath`

---

### 4. Custom picker UX improvements
**When:** 5 May / 6 May

After restoring the picker, several UX gaps were addressed:

- **Collapse on select:** Picker panel collapses automatically when an asset is chosen
- **Label update:** The "Custom (Asset)..." dropdown label updates to show the selected asset name and organisation (e.g. `Unit 123 - ABC · MiX Org`)
- **Single-select for Config Group:** Config group was multi-select but custom standard only allows one. Changed to single-select (clicking an already-selected group deselects it)

---

### 5. Inline diff fallback
**When:** 5 May

When the generate route ran `generate-diff.js` successfully but the subsequent save to the backend DB failed (e.g. schema missing on a new region), the UI would show an error even though the diff was actually computed.

**Fix:** The generate API route now returns the full `diff` JSON inline in its response. The UI uses this directly instead of making a second fetch, so a backend save failure no longer blocks the user from seeing the diff.

---

### 6. `__custom_standard__` asset config never stored — root cause
**When:** 6 May

Despite the picker being restored, newly created test cases with "Custom (Asset)" standard still failed to generate with: `Custom standard asset config is not yet available`.

**Investigation (DB query on DSINTSQL01):**
```sql
SELECT ca.AssetId, LEFT(ca.ConfigJson, 80) ...
FROM configdiff.ConfigDiffCaseAssets ca
WHERE ca.AssetId = '__custom_standard__'
```
Only one `__custom_standard__` row existed in the table (from April 23). All recent cases (`mr_t_4`, `mrt5`) had no `__custom_standard__` row at all.

**Root causes found (two separate bugs):**

**Bug A — `customStandardAssetId` not sent from modal (browser cache)**  
`TestCaseCreationModal` was not passing `customStandardAssetId` to the `/api/delta/create-case` route. The `create-case` route already had the logic to fetch and store the asset config — it just never received the asset ID. Fix: added `customStandardAssetId` to the request body.

The fix was in the deployed image, but users with a cached browser bundle were still running old JavaScript. **Solution: hard refresh (`Ctrl+Shift+R`) on INT** pulls the new bundle.

**Bug B — Edit mode silently wipes `__custom_standard__`**  
When editing an existing test case that uses a custom standard, users can click "Update" without re-selecting the asset (the UI allows it via an edit-mode bypass in `customStdValid`). The `UpsertCaseAssetsAsync` backend call does a full `DELETE` then re-insert, so any asset not explicitly re-sent is lost. The `__custom_standard__` row was being silently deleted on every edit.

**Fix:** `create-case` route now fetches and re-preserves the existing `__custom_standard__` config from the DB when editing without re-selecting.

---

### 7. Generate route — better retry and error messaging
**When:** 6 May

The generate route retried once after 3 seconds if `__custom_standard__` wasn't found. This was not enough for a genuine DB propagation delay, and the error message was unhelpful.

**Fix:**
- Retry loop: 3 attempts with delays of 3s → 4s → 5s (12s total wait)
- Error message changed from *"Custom standard asset config is not yet available. Please retry in a moment."* to an actionable message: *"Custom standard config not found. Open this test case → Edit → re-select the custom standard asset → Save, then generate again."*

---

### 8. "+" button and Edit Case missing in error state
**When:** 6 May

When the Config Delta screen was in an error state, the header reverted to a basic `<select>` with no way to create a new test case or edit the broken one — the user was stuck.

**Fix:**
- Error state now shows the full `CaseSelector` dropdown and the **+** (New Test Case) button
- When the error is a custom-standard failure, an **Edit Case** button appears directly in the error banner, opening the edit modal immediately

---

## Deployments

| Date | Environment | Change |
|---|---|---|
| 5 May | AU, ZA, ENT | Hotfix: silent failure → proper 500 error (`OPEN-2320_SafeErrorStateFix`) |
| 5 May | INT | Inline diff fallback + restored custom picker (`OPEN-2320_InlineDiffAndCustomPicker`) |
| 6 May | INT | Custom standard picker enhancements (collapse, label, single-select) |
| 6 May | INT | `customStandardAssetId` fix + retry logic (PR 144440/144441) |
| Pending INT | INT | Edit-mode preserve, 3-retry loop, error state UX (PR 144448) |
| Pending PROD | AU/ZA/ENT | Same as above via `OPEN-2320_CustomStandardFix` hotfix branch (PR 144449 → INT, then → production) |

---

## Outstanding PRs

| PR | Branch | Target | Status |
|---|---|---|---|
| [144448](https://dev.azure.com/MiXTelematics/OperationsTools/_git/Powerfleet.Automation.UI/pullrequest/144448) | `Config/MR/Fix/OPEN-2320_InlineDiffAndCustomPicker` | `integration` | Open — merge first |
| [144449](https://dev.azure.com/MiXTelematics/OperationsTools/_git/Powerfleet.Automation.UI/pullrequest/144449) | `Config/MR/Hotfix/OPEN-2320_CustomStandardFix` | `integration` → `production` | Open — merge after 144448 confirmed on INT |

---

## Files Changed

| File | Changes |
|---|---|
| `src/app/api/delta/generate/route.ts` | Proper errors, retry loop (3×), actionable error message |
| `src/app/api/delta/create-case/route.ts` | Send `customStandardAssetId`; preserve on edit |
| `src/components/delta/ConfigDeltaView.tsx` | Inline diff, error state header, Edit Case button |
| `src/components/delta/TestCaseCreationModal.tsx` | Restore custom picker, collapse/label, single-select, send asset ID |
