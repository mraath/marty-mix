---
wiki_ingested: 2026-05-28
created: 2026-05-19T08:38
updated: 2026-05-19T08:39
---
# OneDrive AU Cleanup

**Date:** 2026-05-19

## Situation

The folder `C:\Users\MarthinusR\OneDrive AU\OneDrive OLD AU` was a OneDrive Business (Business2 account) sync folder containing 88,125 files.

**Key findings:**
- All 88,125 files were **cloud-only stubs** (online-only, zero local disk usage)
- The Business2 OneDrive account was **not running** — so files could not be hydrated
- Error 362: "The cloud file provider is not running" prevented any copy/move
- **GoPro Backup** (41.51 GB, 4,649 files) was already successfully moved to `D:\OneDrive AU\OneDrive OLD AU\GoPro Backup` ✅

## Decision

Remove the local `C:\Users\MarthinusR\OneDrive AU` folder entirely from the laptop.

- Cloud data remains intact in OneDrive (Business2 / SharePoint)
- Business2 process was not running at time of deletion — no cloud sync of deletion occurred
- If files are ever needed: sign back into the AU OneDrive Business account

## What's on D: (already moved/safe)

| Location | Size | Files |
|---|---|---|
| `D:\OneDrive AU\OneDrive OLD AU\GoPro Backup` | 41.51 GB | 4,649 |

## OneDrive Account Context

| Process | Account |
|---|---|
| `OneDrive.exe /background` | Business1 (work) |
| `OneDrive.exe /client=Personal /background` | Personal |
| *(not running)* | **Business2 = OneDrive AU** ← this folder |

## Next Steps (if ever revisiting)

1. Sign back in to the AU OneDrive Business account
2. Use `robocopy` with `/E /R:30 /W:10 /MT:2 /XO` to copy to D:
3. Run `D:\OneDrive AU\onedrive-cleanup.ps1` to safely remove local stubs after copy

## Related

- Cleanup script: `D:\OneDrive AU\onedrive-cleanup.ps1`
