---
created: 2026-02-16T15:23
updated: 2026-02-18T16:26
---
# Automation Infrastructure: AWS Setup Guide (DEV/INT/PROD)

This guide documents the "moving parts" established for the Powerfleet Automation project. Use this to replicate the setup in INT and Production environments.

## 1. Verified DEV Infrastructure
The following resources are verified and active for the **Development** environment.

| Component | Verified Resource Name | Detail |
| :--- | :--- | :--- |
| **ECS Cluster** | `DEV-Config` | Shared cluster for Config & Automation services |
| **Load Balancer**| `DEV-Config-ExternalALB` | Handles external traffic (HTTPS:443) |
| **Automation UI** | `dev-powerfleet-automation-ui` | Fargate Service (Port 3000) |
| **Automation API**| `dev-powerfleet-automation-api`| Fargate Service (Port 80) |
| **Target Grp (UI)**| `dev-powerfleet-automation-ui` | Points to UI container IPs |
| **Target Grp (API)**| `dev-powerfleet-automation-api`| Points to API container IPs |
| **Log Group (UI)** | `/ecs/dev-powerfleet-automation-ui`| CloudWatch Logs |
| **Log Group (API)**| `/ecs/dev-powerfleet-automation-api`| CloudWatch Logs |

## 2. Naming Conventions for Multi-Environment
To maintain consistency with `Frangular`, use the following pattern:

| Environment | UI DNS | API DNS | Cluster |
| :--- | :--- | :--- | :--- |
| **DEV** | `automation.dev.mixtelematics.com` | `automation-api.dev.mixtelematics.com` | `DEV-Config` |
| **INT** | `automation.int.mixtelematics.com` | `automation-api.int.mixtelematics.com` | `INT-Config` |
| **PROD (ZA)**| `automation.za.mixtelematics.com` | `automation-api.za.mixtelematics.com` | `PROD-Config-ZA`|
| **PROD (US)**| `automation.us.mixtelematics.com` | `automation-api.us.mixtelematics.com` | `PROD-Config-US`|

## 3. Required Environment Variables (ECS Task Definition)
To ensures the API loads the correct configuration, the following environment variables **must** be set in the ECS Task Definition for each service:

| Variable | Recommended Value | Description |
| :--- | :--- | :--- |
| `ASPNETCORE_ENVIRONMENT` | `DEV` / `INT` / `UAT` / `Production` | Standard .NET variable for config loading |
| `Environment` | `DEV` / `INT` / `UAT` / `ZA` / `US` ... | Legacy/Custom variable used by some clients |

### 3.1 Manual Environment Variable Update (Persistent)
To permanently add or change environment variables for an ECS service:
1.  In the left sidebar, click **Task definitions**.
2.  Select the **dev-powerfleet-automation-api** family.
3.  Click the checkbox for the **latest revision** (e.g., revision 3 or higher) and select **Create new revision** -> **Create new revision**.
4.  Scroll down to the **Container definitions** section and click on the container (e.g., `dev-powerfleet-automation-api`).
5.  Scroll down to the **Environment** section.
6.  Under **Environment variables**, click **Add environment variable**:
    - **Key**: `ASPNETCORE_ENVIRONMENT`
    - **Value**: `Development`
7.  Click **Create** at the bottom of the page.
8.  Go back to **Clusters** -> **DEV-Config** -> **Services** -> **dev-powerfleet-automation-api**.
9.  Click **Update**.
10. Under **Task definition revision**, select **Latest** (it should now be the new revision you just created).
11. Click **Update**.

> [!IMPORTANT]
> Failure to set these will cause the API to default to `Production`, which will lead to incorrect API URL resolution and potentially 500 errors if production services are unreachable from non-prod environments.

## 4. PowerShell Verification Script
Copy-paste this to verify the infrastructure status in any environment:

```pwsh
Import-Module AWSPowerShell
$ENV = "dev" # Change to "int", "za", etc.
$CLUSTER = "DEV-Config"

# Check Services
Get-ECSService -Cluster $CLUSTER -Service "$ENV-powerfleet-automation-ui", "$ENV-powerfleet-automation-api" | Select-Object ServiceName, Status

# Check DNS (Requires Route 53 access)
$zone = Get-R53HostedZoneList | Where-Object { $_.Name -match "mixtelematics.com" } | Select-Object -First 1
Get-R53ResourceRecordSet -HostedZoneId $zone.Id | Where-Object { $_.Name -match "automation" }
```

## 5. Connectivity Testing
- **API Health**: `http://automation-api.dev.mixtelematics.com/health`
- **UI Detection**: Visit `http://automation.dev.mixtelematics.com` and verify the detected environment in the console.
