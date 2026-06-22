# Appsettings Audit — 2026-06-22

**Purpose:** Dev flagged incorrect appsettings. Compared Automation.API, ConfigTools.API, Automation.UI, ConfigTools.UI against `Config.Api` as source of truth.

**Repos audited:**

| Label | Path |
|-------|------|
| **Truth** | `C:\Projects\Config.Api` |
| Automation API | `C:\Projects\Powerfleet.Automation` |
| Automation UI | `C:\Projects\Powerfleet.Automation.UI` |
| OpsTools API | `C:\Projects\ConfigTools.API` |
| OpsTools UI | `C:\Projects\ConfigTools.UI` |

---

## Category 1 — Internal service URL mismatches vs Config.Api

Both Automation.API and ConfigTools.API have the **same** wrong values. No difference between them.

| Repo | Env | Setting | Current (wrong) | Config.Api (correct) |
|------|-----|---------|-----------------|----------------------|
| Auto.API + ConfigTools.API | INT | `AuthenticationApiUri` | `http://authentication.mixdevelopment.com` | `http://authentication.int.priv` |
| Auto.API + ConfigTools.API | INT | `AuthorizationApiUri` | `http://authorisation.mixdevelopment.com` | `http://authorisation.int.priv` |
| Auto.API + ConfigTools.API | INT | `MiXFleetServicesApiUrl` | `http://api.fleet.mixdevelopment.com` | `http://api.fleet.int.priv` |
| Auto.API + ConfigTools.API | ENT | `LightningResourceDataUrl` | `http://resourcedata.lght.dub.production.local/` | `http://resourcedata.lght.dub.mixtelematics.com` |
| Auto.API + ConfigTools.API | UK | `LightningResourceDataUrl` | `http://resourcedata.lght.dub.production.local/` | `http://resourcedata.lght.dub.mixtelematics.com` |
| Auto.API + ConfigTools.API | ZA | `LightningResourceDataUrl` | `http://resourcedata.lght.dub.production.local/` | `http://resourcedata.lght.dub.mixtelematics.com` |
| Auto.API + ConfigTools.API | US | `LightningResourceDataUrl` | `http://resourcedata.lght.vir.mixtelematics.com/` | `http://resourcedata.lght.vir.production.local` |

> Config.Api ENT has trailing slashes on `AuthenticationApiUri`, `AuthorizationApiUri`, `MiXFleetServicesApiUrl` — the other repos omit them. Minor.

---

## Category 2 — ConfigTools.API OperationsToolsDb inconsistency (internal)

`Config.Api` has no `OperationsToolsDb` key — no truth comparison possible. This is a mismatch **within ConfigTools.API itself** between environments.

| Envs | `Database=` | `Username=` |
|------|------------|------------|
| INT, AU, UAE, UK | `operations_tools` | `operations_tools_admin` |
| ENT, UAT, US, ZA | `operationstoolsdb` | `appuser` |

One group needs to be corrected to match the other. Confirm which is the intended pattern with whoever owns the Aurora setup.

---

## Category 3 — UI api-urls.ts external proxy URLs

`Config.Api` has no equivalent (internal URLs only). Comparison is against known deployment DNS patterns.

| Repo | Env | Current Value | Expected | Confidence |
|------|-----|--------------|----------|-----------|
| ConfigTools.UI | AU | `https://configtools-api.au.mixtelematics.com` | `https://configtools-api-au.mixtelematics.com` | High — AU DNS uses hyphenated pattern |
| Automation.UI | UAT | `https://uat.mixtelematics.com` | `https://automation-api.uat.mixtelematics.com`? | Needs confirmation |
| Automation.UI | UK | `https://uk.mixtelematics.com` | `https://automation-api.uk.mixtelematics.com`? | Needs confirmation |
| Automation.UI | US | `https://us.mixtelematics.com` | `https://automation-api.us.mixtelematics.com`? | Needs confirmation |
| Automation.UI | AE | `https://ae.mixtelematics.com` | `https://automation-api.ae.mixtelematics.com`? | Needs confirmation |

Automation.UI AU/ENT/ZA correctly use `automation-api.{env}.mixtelematics.com`. UAT/UK/US/AE point to the root domain — may be intentional if Automation.API has no dedicated subdomain in those envs.

---

## Files checked

- `Config.Api\Config.Api\appsettings.{ENV}.json` (INT, DEV, AU, ENT, UAE, UAT, UK, US, ZA)
- `Powerfleet.Automation\Powerfleet.Automation.Api\appsettings.{ENV}.json` (all envs)
- `ConfigTools.API\ConfigTools.API.Api\appsettings.{ENV}.json` (all envs)
- `Powerfleet.Automation.UI\src\environments\api-urls.ts`
- `Powerfleet.Automation.UI\src\environments\host-names.ts`
- `ConfigTools.UI\src\environments\api-urls.ts`
- `ConfigTools.UI\src\environments\host-names.ts`
