---
created: 2026-07-09T00:00
tags: [aws, login, sso, cli]
---

# AWS CLI Login (standard SSO, non-ZAGOV accounts)

For the default/standard AWS accounts (DEV, INT, AU, UK, US, UAT, UAE — everything except ZAGOV, see [[ZAGOV-AWS-Deployment]] for that exception):

```
aws sso login --profile default
```

This opens a browser to an AWS OIDC authorize URL. If the browser session isn't already authenticated with Microsoft Entra ID, it redirects through the org's SSO:

1. Go to **https://myapplications.microsoft.com/**
2. Click the **AWS IAM** app tile
3. This completes the Microsoft-side auth, then redirects back to AWS SSO's device-authorization flow, which finishes the `aws sso login` handshake in the terminal.

Verify it worked:
```
aws sts get-caller-identity --profile default
```
Should return an `Account`, `UserId`, and `Arn` (assumed role, e.g. `AWSReservedSSO_MiX-DevOpsAdmin_...`).

**Note:** the SSO token is short-lived — expect to repeat `aws sso login` periodically (session length not yet confirmed, likely similar to ZAGOV's ~1h pattern but via the standard SSO flow rather than manual credential copy-paste).
