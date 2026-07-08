---
title: Projects Folder Coverage Map
type: source
source: manual
date: 2026-07-08
tags: [projects, coverage, graphify, knowledge-graph, documentation]
status: evergreen
confidence: verified
sources: [[wiki/index]]
---

# Projects Folder Coverage Map

> Documents which repositories in `/c/Projects/` have graphify knowledge graphs and which are covered by the nightly cron job.

## Overview

The `/c/Projects/` directory contains **31 repositories**. As of 2026-07-08, only a subset have `graphify-out/` directories and are included in the nightly graphify update cron.

## Repositories with graphify-out (Nightly Cron Coverage)

| Repo | Path | Files | Status | Notes |
|------|------|-------|--------|-------|
| **SDLC** | `/c/Projects/SDLC/graphify-out` | ~50 | ✅ Active | Powerfleet SDLC docs & code |
| **marty-mix** | `/c/Projects/marty-mix/graphify-out` | 4,949 | ✅ Active | Work wiki — meeting notes, project decisions, tickets |

## Repositories WITHOUT graphify-out (Not in Cron)

| Repo | Path | Type | Notes |
|------|------|------|-------|
| _MiXTelematicsFiles | `/c/Projects/_MiXTelematicsFiles` | Legacy archive | Binary/mixed files |
| Chat Bot Ideas | `/c/Projects/Chat Bot Ideas` | Research | Chatbot experiments |
| Config.Api | `/c/Projects/Config.Api` | .NET API | DeviceConfig API |
| ConfigTools.API | `/c/Projects/ConfigTools.API` | .NET API | Config tools backend |
| ConfigTools.UI | `/c/Projects/ConfigTools.UI` | .NET UI | Config tools frontend |
| customer-central | `/c/Projects/customer-central` | Service | Customer portal |
| Database | `/c/Projects/Database` | SQL | Schema/scripts |
| DST | `/c/Projects/DST` | Research | Daylight Saving Time docs |
| DynaMiX.Backend | `/c/Projects/DynaMiX.Backend` | .NET Core | Core backend |
| DynaMiX.DeviceConfig | `/c/Projects/DynaMiX.DeviceConfig` | .NET | Device config |
| Languaging | `/c/Projects/Languaging` | Research | Language processing |
| MiX.Config.Frangular.API | `/c/Projects/MiX.Config.Frangular.API` | .NET | Frangular API |
| MiX.Config.Frangular.UI | `/c/Projects/MiX.Config.Frangular.UI` | TypeScript | Frangular UI |
| MiX.DataExports | `/c/Projects/MiX.DataExports` | .NET | Data export jobs |
| MiX.DeviceConfig | `/c/Projects/MiX.DeviceConfig` | .NET | Legacy device config |
| MiX.DeviceIntegration.Core | `/c/Projects/MiX.DeviceIntegration.Core` | .NET | Core integration |
| MiX.Fleet.UI | `/c/Projects/MiX.Fleet.UI` | TypeScript | Fleet UI |
| Operations Tools | `/c/Projects/Operations Tools` | Docs | Operations tooling docs |
| out | `/c/Projects/out` | Build output | Compiled artifacts |
| POC | `/c/Projects/POC` | Experiments | Proof of concepts |
| Powerfleet.Automation | `/c/Projects/Powerfleet.Automation` | .NET | Automation backend |
| Powerfleet.Automation.UI | `/c/Projects/Powerfleet.Automation.UI` | TypeScript | Automation UI |
| Resources | `/c/Projects/Resources` | Assets | Shared resources |
| Scripts | `/c/Projects/Scripts` | Scripts | Utility scripts |
| SF Graphs | `/c/Projects/SF Graphs` | Data | Salesforce graphs |
| skills | `/c/Projects/skills` | Skills | Agent skills (deprecated location) |
| t2 | `/c/Projects/t2` | Test | Test project |
| test agent | `/c/Projects/test agent` | Test | Test agent |
| thepopebot | `/c/Projects/thepopebot` | Bot | Chatbot |
| TMP | `/c/Projects/TMP` | Temp | Temporary files |
| Transcriptions | `/c/Projects/Transcriptions` | Media | Meeting transcriptions |

## Graphify Build Candidates

**High priority** (active development, code-heavy):
1. **Powerfleet.Automation** — Core automation platform
2. **Powerfleet.Automation.UI** — React/TypeScript frontend
3. **Config.Api** — DeviceConfig API
4. **DynaMiX.Backend** — Core backend services
5. **MiX.Config.Frangular.API/UI** — Frangular stack

**Medium priority** (docs/research heavy):
6. **DST** — Daylight Saving Time knowledge base
7. **Operations Tools** — Operational documentation
8. **Automation Infrastructure Setup Guide** — AWS/ECS docs

**Low priority** (archived/legacy):
- MiX.* legacy repos
- POC, test projects

## Nightly Cron Configuration

Current cron job: `0903466d4212` (runs daily at 3:00 AM)

**Currently covers:**
- `C:\Personal\AIOS`
- `C:\Personal\obsidian\wiki`
- `C:\Personal\Budget-Dashboard`
- `C:\Personal\skills\au-marketing-skills`
- `C:\Personal\AU` (when graphify-out exists)
- `C:\Projects\marty-mix` (when graphify-out exists)

**To add new repos:** Update the cron prompt with the new paths.

## Adding graphify to a Repo

```bash
cd /c/Projects/<repo-name>
export GEMINI_API_KEY="YOUR_KEY"
~/.venvs/graphify/Scripts/graphify . --backend gemini
# OR for OpenRouter free models:
OPENAI_BASE_URL="https://openrouter.ai/api/v1" \
OPENAI_API_KEY="$OPENROUTER_API_KEY" \
OPENAI_MODEL="nvidia/nemotron-3-nano-30b-a3b:free" \
~/.venvs/graphify/Scripts/graphify . --backend openai
```

After initial build, the repo will be picked up by nightly cron automatically (it checks for `graphify-out/graph.json`).

## See Also

- [[wiki/index]] — Main wiki index
- [graphify skill](../../../.hermes/profiles/aios/skills/graphify/SKILL.md) — Graphify usage reference
- [Nightly cron job](http://localhost:3101/cron/0903466d4212) — Paperclip cron reference