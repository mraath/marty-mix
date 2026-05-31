---
type: source
title: ETS-8669 OMAN Command 45 DST issue
date_ingested: 2026-05-28
original_file: ETS/ETS-8669 OMAN Command 45 DST issue.md
---

## Summary

Full root cause analysis of the March 2026 OMAN DST incident where Command 45 was not reaching FM units in the Schlumberger-OPG-Oman organisation. The investigation methodically ruled out Redis config mismatch and missing logical devices before identifying the actual root cause: the tool was being run from the jumpbox, which cannot correctly route auth requests to the OMAN IIS servers due to network/firewall restrictions. Resolution was running the tool directly on HSOMNIIS19.

## Key Takeaways

- **Root cause:** FMTimeAdjuster run from jumpbox — network blocks auth routing → 100% `UnauthenticatedException`
- **Resolution:** Run tool directly on **HSOMNIIS19**, use the **older** of the two tool versions under `C:\Projects\`
- **Redis verified:** All four web.configs identical (`RedisServerUrl=10.25.2.23, RedisDatabaseIndex=2`) — mismatch eliminated
- **No code changes required** — purely operational fix
- 12 affected FM assets documented (Schlumberger-OPG-Oman, vehicle IDs 768–10210)
- OMAN runs unsupported v18.17 — any fix is a workaround; upgrade is the real solution

## New Entities/Concepts

- [[ETS-8669]] — entity created
- [[OMAN-Environment]] — entity enriched

## Wiki Pages Updated

- [[FMTimeAdjuster]] — CRITICAL jumpbox warning added, OMAN tool versions noted
- [[OMAN-Environment]] — server list and DST gotchas added
- [[Command-45]] — auth architecture and Redis dependency documented
