---
created: 2026-06-18T00:00
updated: 2026-06-19T12:40
wiki_ingested: 2026-06-19
---
# OPEN-2884 — CT - Spike: Survey other teams' AI chatbot approach

> **Status:** In Progress Dev | **Sprint:** 26.14 | **Points:** 2 | **Assignee:** Marthinus Raath  
> **Parent:** [[OPEN-1624 Config change analysis tool]] | **Prerequisite for:** [[OPEN-2362]]

---

## Goal

Survey what model/provider other teams at Powerfleet use for AI chatbot features before upgrading the Config Delta chatbot in OPEN-2362. Avoid duplicating vendor relationships or going against a company-wide decision.

---

## Decision Made (2026-06-19)

**Provider:** Azure OpenAI only — `aura-ai-assistant-int-eu.openai.azure.com`  
**Model:** `gpt-4.1` (not mini — hallucination is a context injection problem, not model quality)  
**Do NOT use:** personal Microsoft Copilot licence (ToS violation), OpenRouter, Groq, Gemini

### Azure OpenAI env vars (ConfigTools.UI `.env.local`)
```
OPENAI_API_KEY=<from ZA ECS task def: za-powerfleet-automation-ui>
OPENAI_API_TYPE=azure
OPENAI_API_BASE=https://aura-ai-assistant-int-eu.openai.azure.com/
OPENAI_DEPLOYMENT_NAME=gpt-4.1
OPENAI_API_VERSION=2024-08-01-preview
```

**Key recovery command:**
```powershell
aws ecs describe-task-definition --task-definition za-powerfleet-automation-ui --profile za --region eu-west-1 --query "taskDefinition.containerDefinitions[0].environment[?name=='OPENAI_API_KEY']"
```

**PROD keys:** `AZURE_OPENAI_API_KEY_PROD_1` / `_PROD_2` in `C:\Projects\.env` → `aura-ai-assistant-prod-eu.openai.azure.com`

---

## POC Done (2026-06-19)

- `src/app/api/chat/route.ts` stripped to Azure OpenAI only — Groq, Gemini, OpenRouter all commented out
- `.env.local` wired with INT vars + real key
- Next: `npm run dev` → open chatbot on a diff → verify `[AI] ▶ Azure OpenAI (gpt-4.1)` in server logs

---

## Questions to Ask the Team (before closing spike)

1. Which Azure OpenAI endpoint are other teams calling — same `aura-ai-assistant-*` or different?
2. Is there a shared internal AI gateway/SDK wrapper we should call instead of Azure OpenAI directly?
3. What deployment name / model are they using in their chatbot?
4. What's their prompt pattern — context injected as system message or user turn?
5. Who owns the `aura-ai-assistant` Azure OpenAI instance? (Need for PROD key rotation / usage limits)
6. Is there a rate limit or quota we need to be aware of on the shared instance?
7. Do we need to register ConfigTools as a consumer, or can we just use the key?

---

## Related

- [[OPEN-1624 Config change analysis tool]] — parent epic
- [[OPEN-1842 Investigate and Optimise Token Usage in AI ChatBot]] — token optimization (same chatbot)
- [[OPEN-1843 Enhance AI ChatBot Follow-Up Question Generation]] — follow-up UX
- [[OPEN-2360]] — decode IDs (prerequisite)
- [[OPEN-2362]] — chatbot hallucination fix (this spike unblocks it)
- [[OPENAI]] — Azure OpenAI endpoint reference
