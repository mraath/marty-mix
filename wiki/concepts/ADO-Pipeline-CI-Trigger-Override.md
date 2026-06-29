# ADO Pipeline CI Trigger Override

> Added: 2026-06-29 | Related: [[OPEN-2936]], [[Powerfleet-Automation-AWS]]

## The Gotcha

ADO stores CI triggers at the **build definition level** (not just in YAML). A pipeline definition can have a `branchFilters` CI trigger baked in via the ADO UI or REST API that **overrides** `trigger: none` in the YAML file.

Result: every commit to the branch fires the pipeline even though the YAML says `trigger: none`.

## Symptom

Paired duplicate runs appear:
- One with empty `TemplateParameters` (the definition-level CI trigger — no params passed)
- One with correct `TemplateParameters` (the intended `trigger_tests` stage queue)

The CI-triggered run always shows `reason: individualCI`, `triggeredByBuild: null`.

## Diagnosis

```powershell
$pat = (Get-Content C:\Projects\SDLC\ENV\.env | Select-String 'GIT_PAT=(.+)').Matches[0].Groups[1].Value.Trim('"')
$b64 = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(":$pat"))
$headers = @{ Authorization = "Basic $b64" }
$def = Invoke-RestMethod "https://dev.azure.com/MiXTelematics/OperationsTools/_apis/build/definitions/2510?api-version=7.1" -Headers $headers
$def.triggers  # non-null with branchFilters = override is active
```

## Fix

```powershell
$def.triggers = @()
$body = $def | ConvertTo-Json -Depth 20 -Compress
Invoke-RestMethod "https://dev.azure.com/MiXTelematics/OperationsTools/_apis/build/definitions/2510?api-version=7.1" -Method Put -Headers $headers -Body $body
```

Applied 2026-06-29 to both affected pipelines.

## API Test Pipeline IDs (project: OperationsTools — one word, no space)

| ID | Name | YAML |
|---|---|---|
| 2510 | Powerfleet.Automation API Tests | `Powerfleet.Automation/api-tests.yml` |
| 2511 | ConfigTools API Tests | `ConfigTools.API/api-tests.yml` |
| 2302 | Powerfleet.Automation Deploy | `Powerfleet.Automation/azure-pipelines.yml` |

## trigger_tests Stage Pattern

Located in `Powerfleet.Automation/azure-pipelines.yml` ~line 370. Queries the build timeline via REST to get actual stage results, then queues the test pipeline per succeeded environment:

```powershell
$body = @{
    definition         = @{ id = 2510 }
    sourceBranch       = "refs/heads/integration"
    templateParameters = @{ TargetEnvOverride = $envName }
} | ConvertTo-Json -Depth 5
Invoke-RestMethod "$apiBase/build/builds?api-version=7.1" -Method Post -Headers $auth -Body $body
```

- Production build → queues all 8 envs (INT, AU, ZA, ENT, UK, US, UAT, AE)
- Integration build → only INT queued (correct)

## SDLC Clone 429

Multiple simultaneous test runs (8 envs firing at once) hit HTTP 429 when all try to `git clone` SDLC. Fix: REST API individual file fetch per job ("Fetch SDLC scripts" PowerShell step). Merged in PR 149062. **Never revert to git clone.**

## TargetEnv Compile-Time Expression

In `api-tests.yml`, `TargetEnv` is resolved at compile-time (`${{ }}`):
- `TargetEnvOverride` param set → `TargetEnv = TargetEnvOverride`
- Else → extracted from `resources.pipeline.AutomationApiDeploy.stageName` (empty if not resource-triggered)

Empty `TargetEnv` = pipeline ran without `templateParameters.TargetEnvOverride`.
