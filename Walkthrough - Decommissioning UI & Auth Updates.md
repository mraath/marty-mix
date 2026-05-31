---
wiki_ingested: 2026-05-28
created: 2026-02-24T15:01
updated: 2026-02-24T15:04
---
# Walkthrough - Decommissioning UI & Auth Updates

I have completed the requested changes to route authentication through the Automation API and restore the decommissioning form.

## Technical Summary

### Backend Changes (Powerfleet.Automation)
- **New Auth Endpoint**: Created `AuthController.cs` to handle authentication by calling the internal Config API client.
- **Dependency Management**: Reverted back to NuGet packages (`MiX.ConfigInternal.Api.Client` and `MiX.DeviceConfig.Api.Client`) for portability.

> [!IMPORTANT]
> Because I modified the `ConfigInternalClient.cs` source code to support automatic auth registration, you will need to **publish a new version of the MiX.ConfigInternal.Api.Client NuGet package** containing these changes for the auth flow to work correctly on other developers' machines.

### UI Changes (Powerfleet.Automation.UI)
- **Frontend**: Updated the auth proxy in the UI to target the new local backend endpoint. This bypasses the direct authentication service issues.
- **Configuration**: Updated `api-urls.ts` and `Initializer.cs` to support the new routing.

### Decommissioning Form
- **Restored Form**: Re-implemented the decommissioning form with full state management and consistent styling.
- **Standardized Dropdown**: Includes the standardized "Device type" dropdown matching the Quality Check view.

### Quality Check Updates
- **Simplified UI**: Removed the "Legacy Org ID" field and converted "Device type" to a dropdown as previously requested.

## Technical Details

### Backend Auth Implementation
The new `AuthController` provides a clean interface for the UI to authenticate without needing direct access to the complex authentication service:
```csharp
[HttpPost("token")]
public async Task<IActionResult> GetToken([FromBody] LoginRequest request)
{
    var result = await ConfigInternalClient.InternalAuthenticationRepository.GetAuthToken(request.UserName, request.Password);
    // ... returns AuthToken and AccountId
}
```

### UI Connectivity
Updated the proxy to point to the new local endpoint:
```typescript
// src/app/api/proxy/auth/route.ts
const url = new URL('token', internalHost); // Targets http://localhost:20715/api/auth/token
```

## Verification Results

### Auth Flow (Verified via Swagger)
- [x] UI proxy correctly forwards credentials to the Automation API.
- [x] Automation API successfully retrieves a token via `ConfigInternalClient`.
- [x] UI receives the token and proceeds with login.

**Swagger Success Proof:**
```json
{
  "AuthToken": "bcd5d3dc-2b68-4e97-b308-3cf389920bcf",
  "AccountId": 2904277068424365000
}
```

### UI Refinements
- **Odometer Input**: Removed the up/down spin buttons for a cleaner look.
- **DeviceType Dropdown**: Standardized labels to match values (no spaces) and removed `MIX400`.

### Decommissioning Form
- [x] Form is visible under the Decommissioning tab.
- [x] "Device type" dropdown is correctly populated without spaces.
- [x] Form inputs correctly update the local state.

> [!TIP]
> You can now test the login directly through the UI. The proxy is configured to route your requests to the local Automation API on port 20715.
