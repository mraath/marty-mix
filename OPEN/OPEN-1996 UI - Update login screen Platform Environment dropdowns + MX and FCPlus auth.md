---
wiki_ingested: 2026-05-28
status: Committed
priority: 1
created: 2026-05-18T09:00
updated: 2026-05-18T09:00
---

# OPEN-1996 UI - Update login screen: Platform/Environment dropdowns + MX and FCPlus auth

JIRA: [OPEN-1996](https://powerfleet.atlassian.net/browse/OPEN-1996)
Parent: [OPEN-1635](https://powerfleet.atlassian.net/browse/OPEN-1635) — FC Plus Installation Automation - Phase 2
Labels: OpsTools
Assignee: Marthinus Raath
Status: Committed | 3 pts
Blocked by: [OPEN-1995](https://powerfleet.atlassian.net/browse/OPEN-1995) — QCAutomationFCPlus backend endpoint
Related: [OPEN-1997](https://powerfleet.atlassian.net/browse/OPEN-1997) — QC execution flow after login

## TODO

```dataviewjs
function callout(text, type) {
	const allText = `> [!${type}]\n` + text;
	const lines = allText.split('\n');
	return lines.join('\n> ') + '\n'
}

const query = `
not done
path includes ${dv.current().file.path}
`;

dv.paragraph(callout('```tasks\n' + query + '\n```', 'todo'));
```

## Open Questions / Meeting Points (2026-05-18)

> Raised with boss — answers needed before implementation is complete.

| # | Question | Why it matters |
|---|----------|----------------|
| 1 | **Which ticket owns the FCPlus auth API endpoint?** Story says "defined in OPEN-1997" but OPEN-1997 is the QC execution flow, not an auth endpoint. No FCPlus auth controller exists in the API yet. | Can't wire FCPlus login without it |
| 2 | **Post-login landing page — what view does the user land on?** Story is silent. Boss said "land op dieselfde form" but which form, and does it differ per platform? | Affects `page.tsx` routing logic |
| 3 | **"Vehicle ID" label change — which story owns it?** Boss said the platform changes the QC form label to "Vehicle ID" for FCPlus. Not in OPEN-1996. Is it OPEN-1997? | Needs to be explicitly in a ticket |
| 4 | **"No additional IMEIs for FCPlus" — which story owns it?** Boss said only primary device for FCPlus. Current QC form allows multiple IMEIs (OPEN-1737). Is this OPEN-1997 scope? | Needs a home in a ticket |
| 5 | **Nordic and NL auth endpoint URLs confirmed?** Story Note 1 says verify against OPEN-2064. No `appsettings.Nordic.json` / `appsettings.NL.json` exist yet. | Can't complete FCPlus auth without URLs |
| 6 | **Can UI work start now independently of OPEN-1995?** All Platform dropdown + Environment conditional logic is pure UI — only the FCPlus auth call is blocked. | Unblocks dev today if yes |

### Boss's response (2026-05-18, paraphrased)

- Auth is the same as MX (*"die auth is deselfde as MX"*)
- After login, lands on the same form — but platform changes the UI to **Vehicle ID** instead of IMEI
- Additional IMEIs not allowed for FCPlus — only the primary device
- Based on platform, calls the new FCPlus manager
- *"Daai is nog nie volledig gespec nie"* — not fully specced yet

---

## File to Modify

- **UI**: `src/components/auth/LoginView.tsx` — add Platform dropdown, reorder fields, conditional Environment logic
- **UI**: `src/app/page.tsx` — update `onLoginSuccess` callback to include `platform`; update routing after login
- **UI proxy**: `src/app/api/proxy/auth/route.ts` — may need to fork auth request based on platform
- **API**: No changes for MX path. FCPlus auth endpoint TBD (pending answer to Q1 above)

---

## Description (from Jira)

### Background and Goal

The login screen currently has three fields: Username, Password, and Environment (auto-detected, read-only). This story reworks the login screen to support two platforms — **MX** (existing behaviour) and **FCPlus** (new) — by introducing a Platform dropdown and making the Environment field conditional. Authentication requires username and password for both platforms. The resulting auth token is valid until expiry and is reused across QC checks — no re-authentication is needed while the token remains active.

### Current Login Screen (AS-IS)

```
┌─────────────────────────────────────────┐
│  powerfleet │ Operations Tools          │
│  🔒 LOGIN                               │
├─────────────────────────────────────────┤
│  Username                               │
│  ┌─────────────────────────────────┐    │
│  │ Enter your username             │    │
│  └─────────────────────────────────┘    │
│                                         │
│  Password                               │
│  ┌─────────────────────────────────┐    │
│  │ ••••••••••••••••                │    │
│  └─────────────────────────────────┘    │
│                                         │
│  Environment  (auto-detected)           │
│  ┌─────────────────────────────────┐    │
│  │ INT                        ▾    │    │  ← disabled/locked
│  └─────────────────────────────────┘    │
│                                         │
│  ┌─────────────────────────────────┐    │
│  │           SIGN IN               │    │
│  └─────────────────────────────────┘    │
└─────────────────────────────────────────┘
```

### New Login Screen (TO-BE)

```
── When MX is selected (default) ────────
│  Platform                               │
│  ┌─────────────────────────────────┐    │
│  │ MX                         ▾    │    │  ← selectable; options: MX, FCPlus
│  └─────────────────────────────────┘    │
│                                         │
│  Environment  (auto-detected)           │
│  ┌─────────────────────────────────┐    │
│  │ INT                        ▾    │    │  ← locked when MX
│  └─────────────────────────────────┘    │
│                                         │
│  Username / Password / Sign In          │

── When FCPlus is selected ──────────────
│  Platform                               │
│  ┌─────────────────────────────────┐    │
│  │ FCPlus                     ▾    │    │
│  └─────────────────────────────────┘    │
│                                         │
│  Environment                            │
│  ┌─────────────────────────────────┐    │
│  │ Nordic                     ▾    │    │  ← selectable; options: Nordic, NL
│  └─────────────────────────────────┘    │
│                                         │
│  Username / Password / Sign In          │
```

### Field Order (vertical)

1. Platform
2. Environment
3. Username
4. Password
5. Sign In button

### Platform Dropdown

| Option | Value | Notes |
|--------|-------|-------|
| MX | `MX` | Default; existing platform |
| FCPlus | `FCPlus` | New platform |

Changing platform resets the Environment field to the correct default for that platform.

### Environment — Conditional Behaviour

**When Platform = MX**

| Hostname pattern | Environment |
|-----------------|-------------|
| localhost / dev / integration | INT |
| au.\* | AU |
| ent.\* | ENT |
| uat.\* | UAT |
| uk.\* | UK |
| us.\* | US |
| za.\* | ZA |
| ae.\* | UAE |

- Auto-detected from hostname, **locked/disabled**
- Label shows `(auto-detected)`

**When Platform = FCPlus**

- Options: **Nordic**, **NL** — Default: Nordic
- **User-selectable** — full dropdown, no auto-detection

### Authentication Behaviour

- Username + password required for both platforms
- On success: **auth token** stored in session state alongside platform and environment
- Token reused until expiry — no re-auth per QC check
- Token expiry → redirect to login (OPEN-2045, existing behaviour)

### Auth Endpoints

| Platform | Auth Endpoint |
|----------|--------------|
| MX | `/api/proxy/auth` → per-environment MX backend (existing, unchanged) |
| FCPlus | FCPlus auth route — defined in OPEN-1997 (TBC — see Open Questions) |

### Functional Requirements

1. Add Platform dropdown as first field. Default: MX.
2. Reorder fields: Platform → Environment → Username → Password → Sign In.
3. MX: Environment auto-detected and locked (no change to detection logic).
4. FCPlus: Environment is user-selectable (Nordic, NL). Default: Nordic.
5. Changing Platform resets Environment and updates lock state.
6. Sign In disabled until all four fields filled.
7. Store platform in session state alongside token and environment.
8. Token reused for all QC checks until expiry.
9. Token expiry: existing redirect behaviour (OPEN-2045) unchanged.
10. MX auth flow not altered.

### Out of Scope

- Backend QC logic for FCPlus (FCPlusQCManager stories)
- The QC form screen and QC execution flow
- FCPlus authentication backend endpoint (consumed here, defined elsewhere)
- API token / x-application-id header handling

### Notes

1. FCPlus environment values (Nordic, NL) must be confirmed — verify against OPEN-2064.
2. Platform value must persist in session state so the QC form knows which endpoint to call.
3. `LoginView.tsx` is the component to modify. Current order: Username → Password → Environment. New order: Platform → Environment → Username → Password.
4. `onLoginSuccess` callback needs `platform` added alongside existing `token`, `environment`, `username`.
