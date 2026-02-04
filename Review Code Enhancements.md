---
created: 2026-02-04T08:42
updated: 2026-02-04T08:42
---
Yeah, the duplication is screaming for some **abstractions** here.[[dev.azure](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/Config.Api/pullrequest/137785?_a=files)]​

## Where inheritance / shared helpers would help

From this PR you’ve effectively got the same “post commissioning / decommissioning” pattern repeated per OEM: update mobile device, update config status, refresh mappings, fire SNS message, sometimes force refresh mapping again, plus IMEI validation boilerplate.[[dev.azure](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/Config.Api/pullrequest/137785?_a=files)]​

Good refactors you could do:

- Base commissioning requestor
    
    - Create a `BaseOemCommissioningRequestor` that encapsulates the common flow:
        
        - validate request (IMEI check etc.),
            
        - call `UpdateMobileDevice`,
            
        - call `UpdateConfigurationStatus`,
            
        - call `ForceRefreshMobileUnitMapping`,
            
        - call `RefreshAssetCameraMappingCache`,
            
        - send SNS message.
            
    - OEM-specific classes just override small hooks (`BuildVehicleIdentification`, “extras” like DME’s track-and-trace update).[[dev.azure](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/Config.Api/pullrequest/137785?_a=files)]​
        
- Shared IMEI validation
    
    - You already extracted `Constants.Regex_IMEIValidator`, but code still calls `Regex.IsMatch` with logging in multiple classes.[[dev.azure](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/Config.Api/pullrequest/137785?_a=files)]​
        
    - Wrap that in something like `ImeiValidator.ValidateOrAppendError(StringBuilder sb, string uniqueIdentifier, string source)` so each requestor just calls one helper.[[dev.azure](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/Config.Api/pullrequest/137785?_a=files)]​
        
- Shared logging helpers
    
    - Log lines like `Logger.LogProduction($"AssetId: {commissioningRequest.AssetId}. Config group was not updated. XyzCommissioningRequestor.");` are repeated with only the class name changing.[[dev.azure](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/Config.Api/pullrequest/137785?_a=files)]​
        
    - Provide a helper `LogConfigGroupNotUpdated(assetId, string requestorName)` in a common base class or utility.
        
- Shared “post success” pipeline
    
    - For multiple OEMs you do: set `IsSuccessful = true`, send SNS, refresh camera cache, force mapping refresh.[[dev.azure](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/Config.Api/pullrequest/137785?_a=files)]​
        
    - Factor into a method like `await HandlePostCommissioningSuccess(cSA, commissioningRequest, commissioningResult, MobileDeviceType.FORD)` etc., with the `MobileDeviceType` as a parameter.[[dev.azure](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/Config.Api/pullrequest/137785?_a=files)]​
        

## Practical “better buttons” you could add

- Template method pattern on `MobileUnitCommissioningRequestor`
    
    - Define a `CommissionAsync` template that calls overridable methods:
        
        - `BeforeCommissionAsync`, `PerformCommissionAsync`, `AfterCommissionSuccessAsync`, `AfterCommissionFailureAsync`.
            
    - Most OEMs will just inherit the default base behavior and override one or two methods.
        
- Result and error objects
    
    - Replace ad-hoc `commissioningResult.IsSuccessful = true;` and message additions with a small `CommissioningOutcome` helper that standardizes success/failure handling and message population.[[dev.azure](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/Config.Api/pullrequest/137785?_a=files)]​
        
- Extension methods / utilities around `ConfigRepo` and `MobileUnits`
    
    - E.g. `ConfigOperations.RefreshAllForAsset(session, assetId, uniqueIdentifier)` which internally does mapping refresh, camera cache refresh, maybe the device template changed action.[[dev.azure](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/Config.Api/pullrequest/137785?_a=files)]​
        

If you want, paste one of the noisier requestor classes and we can sketch an actual base class + one derived implementation so you’ve got a concrete pattern to propose in the next PR.