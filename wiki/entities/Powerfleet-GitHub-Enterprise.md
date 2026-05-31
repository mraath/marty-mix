---
type: entity
entity_type: System
name: Powerfleet GitHub Enterprise
aliases: [powerfleet.ghe.com, GHE, Powerfleet GHE]
sources: [raw/GitHub Login.md]
last_updated: 2026-05-29
---

Powerfleet's self-hosted GitHub Enterprise instance at `powerfleet.ghe.com`. Used for source control across all Powerfleet engineering projects. Marthinus's enterprise username is `marthinus-raath` (distinct from personal `mraath` on `github.com`).

## Key Facts

- **Host**: `powerfleet.ghe.com`
- **Username**: `marthinus-raath`
- **Protocol**: HTTPS
- **Auth method**: `gh` CLI via web browser device flow (`gh auth login --hostname powerfleet.ghe.com`)
- **Token storage**: `gh` CLI keyring (not stored in files)
- **Device auth URL**: `https://powerfleet.ghe.com/login/device`
- Personal `github.com` account (`mraath`) is separate — use `--hostname` flag to target enterprise

## Login SOP

```powershell
gh auth login --hostname powerfleet.ghe.com
# Choose: HTTPS → Yes → Login with web browser
# Copy one-time code → open device URL → paste & authorize

gh auth status --hostname powerfleet.ghe.com  # verify
```

## Connections

- [[Powerfleet-Automation-AWS]] — repos hosted here are deployed via ECS pipelines
- [[AWS-Deployment-Pattern]] — CI/CD pipelines pull from GHE repos
