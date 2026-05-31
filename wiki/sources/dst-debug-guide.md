---
type: source
title: DST Debug Guide — Daylight Saving Time Troubleshooting
date_ingested: 2026-05-28
original_file: DST Daylight Saving Times/DST Debug Guide.md
---

## Summary

Comprehensive troubleshooting guide for DST failures, written for any developer. Covers the two failure modes (manual tool failure vs. automatic service failure), per-environment setup tables (OMAN, AU/SYD, ALG, INT), and step-by-step debug procedures. Contains the critical finding from ETS-8669: the FMTimeAdjuster tool must be run directly on the IIS server, not from a jumpbox. Created 2026-05-14.

## Key Takeaways

- **Two failure modes**: (1) FMTimeAdjuster manual tool fails (auth issues), (2) DaylightSavingAdjustmentService stops/misconfigures
- **Auth architecture**: Both DynaMiX.Api and FMTimeAdjuster.Api must point at **identical** `RedisServerUrl` + `RedisDatabaseIndex`
- **CRITICAL lesson (OMAN, March 2026):** Tool must be run directly on IIS server — jumpbox causes 100% auth failure
- Axiom (`app.axiom.co`, SAML slug `powerfleet`) is the fastest way to check logs across all environments
- For AU, use the automatic service debug path (not FMTimeAdjuster)
- Message status codes: `1=New, 4=Sent, 9=Received, 10=Accepted, 13=Acknowledged, 14=Expired`

## New Entities/Concepts

- [[OMAN-Environment]] — entity created with per-server detail
- [[ETS-8669]] — entity created

## Wiki Pages Updated

- [[FMTimeAdjuster]] — authentication architecture and per-env servers added
- [[DaylightSavingAdjustmentService]] — debug steps and app config keys added
- [[Command-45]] — logical device filter rules documented
