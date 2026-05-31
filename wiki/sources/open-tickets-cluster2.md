---
type: source
title: OPEN Tickets — Ops Tools Core (Cluster 2)
date_ingested: 2026-05-28
original_file: OPEN/ (79 files)
---

## Summary

79 OPEN Jira ticket notes covering the full history of the Ops Tools project — AWS deployments, Config Delta, QC/Decomm automation, AI chatbot, pipeline setup, and Config Groups page bugs (OPEN-235 through OPEN-2320). All tagged with `wiki_ingested: 2026-05-28`. Key tickets: OPEN-1715 (AU AWS), OPEN-1928 (ZA), OPEN-1931 (ENT), OPEN-1788 (AI chatbot), OPEN-2013 (prod pipeline), OPEN-1672 (centralised login).

## Key Takeaways

- **OPEN-1788**: AI ChatBot panel for Config Delta — slide-in from right, uses OpenRouter API, Groq fallback. Assigned to Marthinus, In Progress Dev.
- **OPEN-2013**: Production branch auto-deploy pipelines for API and UI — status: Ready for Review (QA). Assigned to Marthinus.
- **OPEN-1672**: Centralised login for Automation UI — implements MiX auth proxy for multi-env login
- **OPEN-1928/1931**: ZA and ENT DNS confirmed live (2026-04-07)
- **OPEN-1715**: AU deployment done (captured in `au-automation-setup.md`)
- Bulk of older tickets (OPEN-235–OPEN-997) are Config Groups page defects/enhancements from 2022-2023

## Wiki Pages Updated

- [[Ops-Tools]] — sprint ticket detail (OPEN-2013 pipeline, OPEN-1788 chatbot)
- [[Config-Delta-Tool]] — OPEN-1788 AI chatbot panel added
- [[Powerfleet-Automation-AWS]] — OPEN-1928/1931 ZA/ENT DNS confirmed
