---
wiki_ingested: 2026-06-19
created: 2026-03-31T16:48
updated: 2026-06-19T12:44
---
# Azure OpenAI — Company Reference

> Company-wide Azure OpenAI setup for Operations Tools / ConfigTools chatbot.

---

## Endpoints

| Environment | Endpoint | Status |
|---|---|---|
| INT (dev) | `https://aura-ai-assistant-int-eu.openai.azure.com/` | ✅ In use — all envs including PROD ECS |
| PROD | `https://aura-ai-assistant-prod-eu.openai.azure.com/` | Keys available, not yet deployed to ECS |

**Deployment name:** `gpt-4.1`  
**API version:** `2024-08-01-preview`

---

## Key Storage

| Key var | Location | Notes |
|---|---|---|
| `AZURE_OPENAI_API_KEY` (INT) | `C:\Projects\.env` | Same key used across all Automation UI ECS task defs |
| `AZURE_OPENAI_API_KEY_PROD_1` | `C:\Projects\.env` | PROD endpoint — not yet in any ECS task def |
| `AZURE_OPENAI_API_KEY_PROD_2` | `C:\Projects\.env` | PROD endpoint backup key |

**Key recovery (if C:\Projects\.env is masked):**
```powershell
# Pull INT key from any env's Automation UI task def — all share the same key
aws ecs describe-task-definition --task-definition za-powerfleet-automation-ui --profile za --region eu-west-1 --query "taskDefinition.containerDefinitions[0].environment[?name=='OPENAI_API_KEY']"
```

---

## Current ECS Deployment State (verified 2026-06-19)

ALL Powerfleet Automation UI environments (AU/ZA/UK/US/ENT/UAE/UAT) currently use the **INT** endpoint — not PROD. This is intentional for now.

```json
{
  "OPENAI_API_TYPE": "azure",
  "OPENAI_API_BASE": "https://aura-ai-assistant-int-eu.openai.azure.com/",
  "OPENAI_API_VERSION": "2024-08-01-preview",
  "OPENAI_DEPLOYMENT_NAME": "gpt-4.1",
  "OPENAI_API_KEY": "<INT key — see C:\\Projects\\.env>"
}
```

---

## ConfigTools.UI — Local Dev Setup

File: `C:\Projects\ConfigTools.UI\.env.local`

```
OPENAI_API_KEY=<AZURE_OPENAI_API_KEY from C:\Projects\.env>
OPENAI_API_TYPE=azure
OPENAI_API_BASE=https://aura-ai-assistant-int-eu.openai.azure.com/
OPENAI_DEPLOYMENT_NAME=gpt-4.1
OPENAI_API_VERSION=2024-08-01-preview
```

Auth header used by code: `api-key: {OPENAI_API_KEY}` (NOT `Authorization: Bearer`)

---

## GitHub Copilot (separate — dev tooling only)

Company has GitHub Copilot Enterprise via Powerfleet enterprise account.  
Login: AD account via `https://github.com/enterprises/powerfleet/sso` (Javier manages licences).  
**Do NOT use for product/API calls** — dev IDE tool only. Not an API you can call programmatically.

---

## Chatbot Provider History

| Provider | Status | Reason |
|---|---|---|
| OpenRouter (free models) | ❌ Disabled (2026-06-19) | Personal key, not enterprise-approved |
| Groq (free models) | ❌ Disabled (2026-06-19) | Personal key, not enterprise-approved |
| Gemini (free models) | ❌ Disabled (2026-06-19) | Personal key, not enterprise-approved |
| Azure OpenAI (INT) | ✅ Active | Company infrastructure, compliant |

All fallbacks commented out in `ConfigTools.UI/src/app/api/chat/route.ts` as of OPEN-2884 POC.

---

## Related

- [[OPEN-1624 Config change analysis tool]] — chatbot parent epic
- [[OPEN-1842 Investigate and Optimise Token Usage in AI ChatBot]] — token optimization
- [[OPEN-2884 CT - Spike Survey other teams AI chatbot approach]] — current spike
- [[OPEN-2362]] — chatbot hallucination fix (uses this key)
- [[Operations Tools]] — sprint context
