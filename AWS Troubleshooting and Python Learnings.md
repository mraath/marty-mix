---
created: 2026-02-16T15:23
updated: 2026-02-16T15:30
---
# AWS CLI & Python Environment Troubleshooting (Friday/Monday Learnings)

During the setup of the Powerfleet Automation infrastructure, we encountered a systemic failure of the local AWS CLI and Python environments. This document summarizes the findings and the permanent bypass strategies implemented.

## 1. The Core Issue: Systemic Python Corruption
The AWS CLI v2 and multiple Python versions (3.11, 3.13) on the system were found to be missing critical standard library modules.

- **Symptoms**: `ModuleNotFoundError: No module named 'botocore.credentials'` and `ModuleNotFoundError: No module named 'difflib'`.
- **Root Cause**: Corrupted site-packages or incomplete Python installations in protected system directories (`C:\Program Files\Amazon\AWSCLI` and `C:\Program Files\Python311`).
- **Attempts to Fix**: Standard MSI re-installs and `pip install` repairs failed due to permission constraints and deep-seated corruption in the shared library paths.

## 2. The Healthy Path: Python 3.12
Investigation revealed that **Python 3.12** is currently the only fully functional Python environment on the system. 
- **Bypass**: We re-routed critical AWS interactions to use Python 3.12 or avoided the system CLI where possible.

## 3. The "Silent Blocker": Expired Tokens
Both AWS and NPM tokens were found to be expired simultaneously, causing:
- AWS CLI calls to fail with authentication errors.
- MCP servers (which depend on `npx`) to fail to pull updates or authenticate with registries.

## 4. Successful Bypass Strategies
To stay productive without a full OS/Python wipe, we implemented the following:

### A. MCP Server Recovery via Node.js
Instead of relying on the broken system AWS CLI, we configured the AWS MCP server in `claude_desktop_config.json` to use `npx` (Node.js). This ensures the agent can interact with AWS even if the local CLI is unstable.

### B. PowerShell as the Source of Truth
We discovered that the `AWSPowerShell` (monolith) module is fully functional and bypasses the Python-based CLI issues. When in doubt, use PowerShell for AWS resource discovery:
```pwsh
Import-Module AWSPowerShell
Get-STSCallerIdentity
```

### C. Authentication via saml2aws
The primary re-authentication method for the `MiX-DevOpsAdmin` role is via Okta using:
```pwsh
saml2aws login -a default
```
This updates the local AWS credentials file directly, fixing both the CLI and MCP access.
