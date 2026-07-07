---
created: 2026-05-27
wiki_ingested: 2026-05-28
updated: 2026-07-07
---
# ConfigTools URLs

| Env | UI URL | API URL |
|-----|--------|---------|
| INT | [https://configtools.mixdevelopment.com](https://configtools.mixdevelopment.com) | [https://configtools-api.mixdevelopment.com/swagger](https://configtools-api.mixdevelopment.com/swagger) |
| AU | [https://configtools.au.mixtelematics.com](https://configtools.au.mixtelematics.com) | [https://configtools-api.au.mixtelematics.com/swagger/index.html](https://configtools-api.au.mixtelematics.com/swagger/index.html) |
| ZA | [https://configtools.za.mixtelematics.com](https://configtools.za.mixtelematics.com) | [https://configtools-api.za.mixtelematics.com/swagger/index.html](https://configtools-api.za.mixtelematics.com/swagger/index.html) |
| UK | [https://configtools.uk.mixtelematics.com](https://configtools.uk.mixtelematics.com) | [https://configtools-api.uk.mixtelematics.com/swagger/index.html](https://configtools-api.uk.mixtelematics.com/swagger/index.html) |
| US | [https://configtools.us.mixtelematics.com](https://configtools.us.mixtelematics.com) | [https://configtools-api.us.mixtelematics.com/swagger/index.html](https://configtools-api.us.mixtelematics.com/swagger/index.html) |
| ENT | [https://configtools.ent.mixtelematics.com](https://configtools.ent.mixtelematics.com) | [https://configtools-api.ent.mixtelematics.com/swagger/index.html](https://configtools-api.ent.mixtelematics.com/swagger/index.html) |
| UAE | [https://configtools.ae.mixtelematics.com](https://configtools.ae.mixtelematics.com) | [https://configtools-api.ae.mixtelematics.com/swagger/index.html](https://configtools-api.ae.mixtelematics.com/swagger/index.html) |

> **INT** is on the `mixdevelopment.com` domain, not `mixtelematics.com`.
> **AU uses the DOT form here (`configtools.au`), unlike Automation UI's AU which uses a HYPHEN (`automation-au`).** Confirmed live 2026-07-06 from the user's own ConfigTools production URL list — ConfigTools has **no** hyphen exception; all 6 prod envs (AU/ZA/UK/US/ENT/UAE) consistently use `configtools.{env}.mixtelematics.com`. Do not assume the Automation UI AU quirk applies here — it doesn't. This correction supersedes the prior note below.
> ~~AU will break the dot pattern — use `configtools-au.mixtelematics.com` (hyphen)~~ — incorrect, superseded 2026-07-07.
> **UAT** is excluded from this list — ECR repos still missing as of 2026-07-06.
> **UAE** uses `ae.` in the subdomain, not `uae.`.
