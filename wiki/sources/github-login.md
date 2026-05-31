---
type: source
title: GitHub CLI Login - Powerfleet Enterprise
date_ingested: 2026-05-29
original_file: raw/GitHub Login.md
---

## Summary

A short SOP for authenticating the `gh` CLI against Powerfleet's GitHub Enterprise instance at `powerfleet.ghe.com`. Uses HTTPS protocol with browser-based device flow authentication. Marthinus's enterprise username is `marthinus-raath` (separate from personal `mraath` on `github.com`).

## Key Takeaways

- Always use `--hostname powerfleet.ghe.com` flag with `gh` commands to target enterprise
- Auth flow: copy one-time code → `https://powerfleet.ghe.com/login/device` → authorize
- Token stored in `gh` CLI keyring, not in files
- Verify with `gh auth status --hostname powerfleet.ghe.com`

## New Entities/Concepts

- `Powerfleet-GitHub-Enterprise` (entity) — created

## Wiki Pages Updated

- `wiki/index.md` — added entity entry
- `wiki/log.md` — appended ingest record
