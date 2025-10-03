---
created: 2025-10-03T12:46
updated: 2025-10-03T12:48
---
## Prompt 1

You are a software architect with over 25 years experience.

I have OLD code and NEW Code. Please see the sections below. 
For some reason the NEW CODE is not placing assets (Mobileunits) into a status of "Configuration Changed" when changing the Event Template. This works for the OLD CODE though. Please investigate and give your best idea as to what could be the difference and where I should investigate further.


NEW CODE:


```
public async Task<UpdateResult> UpdateConfigurationGroup(string authToken, long orgId, long configurationGroupId, ConfigurationGroup configurationGroupToUpdate)
{
  UpdateResult updateResult = new UpdateResult() { Success = true, Message = new List<string>() };
  try
  {
    await ValidateConfigurationGroupName(authToken, configurationGroupToUpdate.Name, orgId, configurationGroupId).ConfigureAwait(false);
    ConfigurationGroup configurationGroupFromDb = await Task.Run(() => _deviceConfigRepo.GetConfigurationGroup(configurationGroupId)).ConfigureAwait(false);

    List<long> mobileUnitIdsForConfigurationGroup = await _deviceConfigRepo.GetMobileUnitIdsForConfigurationGroup(configurationGroupId).ConfigureAwait(false);
    bool configurationGroupHasMobileUnits = mobileUnitIdsForConfigurationGroup != null && mobileUnitIdsForConfigurationGroup.Count > 0;

    MobileDeviceTemplate mobileDeviceTemplateFromUi = await Task.Run(() => _deviceConfigRepo.GetMobileDeviceTemplate(configurationGroupToUpdate.MobileDeviceTemplateId)).ConfigureAwait(false);

    ValidateFixLocationTemplateSelection(configurationGroupToUpdate, mobileDeviceTemplateFromUi);

    if (configurationGroupHasMobileUnits)
    {
      MobileDeviceTemplate mobileDeviceTemplate = await _deviceConfigRepo.GetTemplateForMobileDeviceTemplateId(configurationGroupFromDb.MobileDeviceTemplateId).ConfigureAwait(false);

      if (mobileDeviceTemplate.DefinitionDeviceId != mobileDeviceTemplateFromUi.DefinitionDeviceId)
        throw new Exception(ErrorMessages.ConfigAdmin.CONFIG_GROUP_MOBILE_DEVICE_TYPE_CONFLICT);
    }

    configurationGroupFromDb.Name = configurationGroupToUpdate.Name;

    bool eventTemplateChanged = configurationGroupFromDb.EventTemplateId != configurationGroupToUpdate.EventTemplateId;
    bool mobileTemplateChanged = configurationGroupFromDb.MobileDeviceTemplateId != configurationGroupToUpdate.MobileDeviceTemplateId;
    bool locationTemplateChanged = configurationGroupFromDb.LocationTemplateId != configurationGroupToUpdate.LocationTemplateId;

    configurationGroupFromDb.EventTemplateId = configurationGroupToUpdate.EventTemplateId;
    configurationGroupFromDb.MobileDeviceTemplateId = configurationGroupToUpdate.MobileDeviceTemplateId;
    configurationGroupFromDb.LocationTemplateId = configurationGroupToUpdate.LocationTemplateId;
    CurrentUserSession session = await _authenticationProxy.GetSession(authToken).ConfigureAwait(false);
    await _deviceConfigRepo.AddOrUpdateConfigurationGroup(configurationGroupToUpdate, session.FullName).ConfigureAwait(false);

    if (eventTemplateChanged || mobileTemplateChanged || locationTemplateChanged)
    {
      List<MobileUnit> assets = await _deviceConfigRepo.GetMobileUnitsForConfigurationGroup(orgId, configurationGroupId).ConfigureAwait(false);
      var mum = DependencyRegistry.GetInstance<IMobileUnitManager>(false);
      bool isCalampConfigGroup = assets.Any(x => mum.IsTheDeviceAvailableForAsset(x.AssetId, LogicalDevices.CalAmp_Logical));
      bool isCellocatorConfigGroup = assets.Any(x => x.UniqueIdentifierPropertyId == Properties.UNIQUE_IDENTIFIER_PROPERTY_ID_CELLOCATORSERIAL);//For Cellocator units, the config status should always be Configuration Accepted CANIQ-23
      bool forceSetConfigAccepted = isCalampConfigGroup || isCellocatorConfigGroup;

      foreach (MobileUnit mu in assets)
      {
        if (mu != null)
        {
          //If the current configuration status is notcommissioned this shouldnt be set
          if (mu.ConfigurationStatus != ConfigurationStatus.NotCommissioned)
          {
            if (forceSetConfigAccepted)
            {
              mu.ConfigurationStatus = ConfigurationStatus.ConfigurationAccepted;
            }
            else
            {
              mu.ConfigurationStatus = ConfigurationStatus.ConfigurationChanged;
            }
          }

          if (eventTemplateChanged)
          {
            await _deviceConfigRepo.ResetAssetMobileUnit(mu.AssetId, ResetType.Events).ConfigureAwait(false);
          }

          if (mobileTemplateChanged)
          {
            await _deviceConfigRepo.ResetAssetMobileUnit(mu.AssetId, ResetType.Events).ConfigureAwait(false);
          }

          await _deviceConfigRepo.UpdateConfigurationStatus(session, mu.Id, mu.ConfigurationStatus).ConfigureAwait(false);
        }
      }

      //cache update after templates updated
      var result = await _deviceConfigRepo.UpdateConfigurationGroupHashCache(configurationGroupId,
        new ConfigurationGroupCacheDto()
        {
          MobileDeviceTemplateId = configurationGroupToUpdate.MobileDeviceTemplateId,
          EventTemplateId = configurationGroupToUpdate.EventTemplateId,
          LocationTemplateId = configurationGroupToUpdate.LocationTemplateId
        }).ConfigureAwait(false);
    }

    //Refresh asset camera mapping cache at template level
    IConfigCachingManager cacheManager = DependencyRegistry.GetInstance<IConfigCachingManager>(false);
    await cacheManager.RefreshTemplateAssetCameraMappingCache(configurationGroupToUpdate.MobileDeviceTemplateId).ConfigureAwait(false);

    IMobileDeviceTemplateManager mobileDeviceTemplateManager = DependencyRegistry.GetInstance<IMobileDeviceTemplateManager>(false);
    await mobileDeviceTemplateManager.MobileDeviceTemplateChangeActions(authToken, configurationGroupToUpdate.MobileDeviceTemplateId).ConfigureAwait(false);

    await cacheManager.RefreshOverriddenMobileUnitEventsConditionsCachePerTemplate(configurationGroupToUpdate.EventTemplateId).ConfigureAwait(false);

    using IEventTemplateManager man = DependencyRegistry.GetInstance<IEventTemplateManager>(false);
    await man.EventTemplateChangeActions(authToken, configurationGroupToUpdate.EventTemplateId).ConfigureAwait(false);
  }
  catch (Exception ex)
  {
    updateResult.Success = false;
    updateResult.Message.Add($"{ex.Message}");
  }
  return updateResult;
}
```



OLD CODE:


```
public void UpdateConfigurationGroup(string authToken, long orgId, long configurationGroupId, ConfigurationGroup configurationGroupToUpdate)
{
  var mobileUnitManager = DependencyResolver.GetInstance<IMobileUnitManager>();

  ValidateConfigurationGroupName(configurationGroupToUpdate.Name, orgId, configurationGroupId);
  ConfigurationGroup configurationGroupFromDb = ConfigAdminRepository.GetConfigurationGroup(configurationGroupId);

  bool configurationGroupHasMobileUnits = DoesConfigurationGroupContainAnyMobileUnits(authToken, configurationGroupId);

  MobileDeviceTemplate mobileDeviceTemplateFromUi = ConfigAdminRepository.GetMobileDeviceTemplateAggregateForDeviceAvailability(configurationGroupToUpdate.MobileDeviceTemplateId);

  ValidateFixLocationTemplateSelection(configurationGroupToUpdate, mobileDeviceTemplateFromUi);

  if (configurationGroupHasMobileUnits)
  {
    MobileDeviceTemplate mobileDeviceTemplate = ConfigAdminRepository.GetMobileDeviceTemplate(configurationGroupFromDb.MobileDeviceTemplateId);
    if (mobileDeviceTemplate.DefinitionDeviceId != mobileDeviceTemplateFromUi.DefinitionDeviceId)
      throw new Exception(ConfigConstants.ErrorMessages.ConfigAdmin.CONFIG_GROUP_MOBILE_DEVICE_TYPE_CONFLICT);
  }

  configurationGroupFromDb.Name = configurationGroupToUpdate.Name;

  bool eventTemplateChanged = configurationGroupFromDb.EventTemplateId != configurationGroupToUpdate.EventTemplateId;
  bool mobileTemplateChanged = configurationGroupFromDb.MobileDeviceTemplateId != configurationGroupToUpdate.MobileDeviceTemplateId;
  bool locationTemplateChanged = configurationGroupFromDb.LocationTemplateId != configurationGroupToUpdate.LocationTemplateId;

  configurationGroupFromDb.EventTemplateId = configurationGroupToUpdate.EventTemplateId;
  configurationGroupFromDb.MobileDeviceTemplateId = configurationGroupToUpdate.MobileDeviceTemplateId;
  configurationGroupFromDb.LocationTemplateId = configurationGroupToUpdate.LocationTemplateId;

  ConfigAdminRepository.AddOrUpdateConfigurationGroup(configurationGroupToUpdate);

  if (eventTemplateChanged || mobileTemplateChanged || locationTemplateChanged)
  {
    var assets = ConfigAdminRepository.GetMobileUnitAggregatesByConfigurationGroupId(configurationGroupFromDb.Id);

    bool isCalampConfigGroup = assets.Any(x => mobileUnitManager.IsTheDeviceAvailableForAsset(x.AssetId, LogicalDevices.CalAmp_Logical));
    bool isCellocatorConfigGroup = assets.Any(x => x.UniqueIdentifierPropertyId == Properties.UNIQUE_IDENTIFIER_PROPERTY_ID_CELLOCATORSERIAL);//For Cellocator units, the config status should always be Configuration Accepted CANIQ-23
    bool forceSetConfigAccepted = isCalampConfigGroup || isCellocatorConfigGroup;

    foreach (MobileUnit mu in assets)
    {
      //If the current configuration status is notcommissioned this shouldnt be set
      if (mu != null && mu.ConfigurationStatus != ConfigurationStatus.NotCommissioned)
      {
        if (forceSetConfigAccepted)
        {
          mu.ConfigurationStatus = ConfigurationStatus.ConfigurationAccepted;
        }
        else
        {
          mu.ConfigurationStatus = ConfigurationStatus.ConfigurationChanged;
        }
      }

      if (eventTemplateChanged)
      {
        ConfigAdminRepository.DeleteOverridenEventRecords(mu, false);
      }

      if (mobileTemplateChanged)
      {
        ConfigAdminRepository.DeleteOverridenDeviceRecords(mu, false);
      }
    }

    IDeviceIntegrationManager deviceIntegrationManager = DependencyResolver.GetInstance<IDeviceIntegrationManager>();

    var assetsInMobileDeviceTemplate = DependencyResolver.GetInstance<IConfigAdminSqlRepository>().GetAssetsByMobileDeviceTemplate(configurationGroupFromDb.MobileDeviceTemplateId).ConfigureAwait(false).GetAwaiter().GetResult();
    //ConfigurationStatus for Calamp and Cellocator are not in AlwaysAcceptedWorkflow Logical
    assetsInMobileDeviceTemplate.ForEach(item => item.NewStatus = assets.Where(x => x.AssetId == item.MobileUnitId).FirstOrDefault().ConfigurationStatus);

    deviceIntegrationManager.UpdateMobileUnitsConfigurationViaWorkflow(assetsInMobileDeviceTemplate, CurrentSession.UserName);

    //cache update after templates updated
    var result = ConfigInternalClient.Caching.UpdateMobileUnitConfigurationGroupCache(authToken, configurationGroupId,
      new ConfigurationGroupCacheDto()
      {
        MobileDeviceTemplateId = configurationGroupToUpdate.MobileDeviceTemplateId,
        EventTemplateId = configurationGroupToUpdate.EventTemplateId,
        LocationTemplateId = configurationGroupToUpdate.LocationTemplateId
      },
      null).ConfigureAwait(false).GetAwaiter().GetResult();
  }

  //Refresh asset camera mapping cache at template level
  ConfigInternalClient.Caching.RefreshTemplateAssetCameraMappingCache(configurationGroupToUpdate.MobileDeviceTemplateId);
  ConfigInternalClient.InternalMobileDeviceTemplateRepository.MobileDeviceTemplateChangeActions(authToken, configurationGroupToUpdate.MobileDeviceTemplateId);
}
```


## Result 1

This is an interesting problem, and as a software architect with decades of experience, I can tell you that subtle differences in refactored or modernized code—especially around **asynchronicity** and **persistence**—are common sources of such bugs.

The core issue appears to be that the **OLD CODE** is successfully persisting the `ConfigurationStatus` change, while the **NEW CODE** is not, specifically when only `eventTemplateChanged` is true.

Here's my investigation and where you should focus your efforts.

---

## 1. Key Difference: Persistence of `ConfigurationStatus`

The most critical difference lies in _how_ and _when_ the `ConfigurationStatus` is persisted in the database.

### OLD CODE

In the OLD CODE, the `MobileUnit` objects (`mu`) in the `assets` collection are updated in memory within the `foreach` loop:

C#

```
// OLD CODE - Inside foreach loop:
if (forceSetConfigAccepted)
{
  mu.ConfigurationStatus = ConfigurationStatus.ConfigurationAccepted;
}
else
{
  mu.ConfigurationStatus = ConfigurationStatus.ConfigurationChanged;
}
// ...
// NO explicit database update inside the foreach loop for mu.ConfigurationStatus
```

Crucially, the OLD CODE then calls this block _after_ the `foreach` loop:

C#

```
// OLD CODE - After foreach loop:
IDeviceIntegrationManager deviceIntegrationManager = DependencyResolver.GetInstance<IDeviceIntegrationManager>();
// ... preparation of assetsInMobileDeviceTemplate
deviceIntegrationManager.UpdateMobileUnitsConfigurationViaWorkflow(assetsInMobileDeviceTemplate, CurrentSession.UserName);
```

This `deviceIntegrationManager.UpdateMobileUnitsConfigurationViaWorkflow` is the **implicit persistence mechanism** that takes the in-memory changes to `mu.ConfigurationStatus` (which were copied into `assetsInMobileDeviceTemplate`) and writes them to the database.

### NEW CODE

The NEW CODE explicitly persists the status _inside_ the `foreach` loop:

C#

```
// NEW CODE - Inside foreach loop:
// ... set mu.ConfigurationStatus logic

if (eventTemplateChanged)
{
  await _deviceConfigRepo.ResetAssetMobileUnit(mu.AssetId, ResetType.Events).ConfigureAwait(false);
}

if (mobileTemplateChanged)
{
  await _deviceConfigRepo.ResetAssetMobileUnit(mu.AssetId, ResetType.Events).ConfigureAwait(false);
}

await _deviceConfigRepo.UpdateConfigurationStatus(session, mu.Id, mu.ConfigurationStatus).ConfigureAwait(false); // <--- THIS IS THE EXPLICIT PERSISTENCE
```

## 2. The Smoking Gun: `eventTemplateChanged` Logic

The logic for which template changes trigger a **reset** is where the bug is likely manifesting in the NEW CODE.

In the NEW CODE:

1. **If `mobileTemplateChanged` is true**, the code calls `_deviceConfigRepo.ResetAssetMobileUnit(mu.AssetId, ResetType.Events)`. This seems incorrect; if the mobile template changes, it should likely reset the Device/Mobile configuration (`ResetType.MobileDevice` or similar), not the Events configuration (`ResetType.Events`).
    
2. **If `eventTemplateChanged` is true**, the code calls `_deviceConfigRepo.ResetAssetMobileUnit(mu.AssetId, ResetType.Events)`. This seems correct for event changes.
    

Now look at the OLD CODE persistence mechanism:

C#

```
// OLD CODE - Inside foreach loop:
if (eventTemplateChanged)
{
  ConfigAdminRepository.DeleteOverridenEventRecords(mu, false);
}

if (mobileTemplateChanged)
{
  ConfigAdminRepository.DeleteOverridenDeviceRecords(mu, false);
}
```

The key problem in the NEW CODE is what happens inside the `if (eventTemplateChanged || mobileTemplateChanged || locationTemplateChanged)` block when _only_ `eventTemplateChanged` is true:

### The Problematic Flow (NEW CODE, when only `eventTemplateChanged` is true)

1. `mu.ConfigurationStatus` is set to `ConfigurationChanged`. (Good)
    
2. `if (eventTemplateChanged)` is true, so `await _deviceConfigRepo.ResetAssetMobileUnit(mu.AssetId, ResetType.Events)` is called. (Good/Expected behavior)
    
3. `if (mobileTemplateChanged)` is false.
    
4. `await _deviceConfigRepo.UpdateConfigurationStatus(session, mu.Id, mu.ConfigurationStatus)` is called. (Expected to save `ConfigurationChanged`)
    

### Hypothesis

The most plausible explanation is that the asynchronous call to `_deviceConfigRepo.ResetAssetMobileUnit(mu.AssetId, ResetType.Events)` in step 2 is **either implicitly or explicitly resetting the `ConfigurationStatus` to a different value (e.g., `ConfigurationAccepted`)** _after_ it was set to `ConfigurationChanged` in step 1, but _before_ or _concurrently with_ step 4 trying to save `ConfigurationChanged`.

This is a very common race condition or side-effect when mixing asynchronous calls and database operations in a loop.

---

## 3. Areas for Investigation

I recommend focusing your investigation on these two points:

### 1. The `ResetAssetMobileUnit` Implementation (Highest Priority)

**Investigate the implementation of `_deviceConfigRepo.ResetAssetMobileUnit(mu.AssetId, ResetType.Events)`.**

- **Does this method internally modify or update the `MobileUnit`'s `ConfigurationStatus`?** It's highly likely that a "reset" function, particularly one related to configuration, performs a full state change, which might include setting the status to `ConfigurationAccepted` or even `ConfigurationPending` as part of its execution.
    
- If it _does_ update the status, this update is racing with (or potentially overwriting) the explicit `UpdateConfigurationStatus` call later in the loop.
    

### 2. The Logic Flow in the `foreach` Loop

If `ResetAssetMobileUnit` _does_ change the status, you need to re-sequence the NEW CODE logic:

**NEW CODE (Proposed Fix/Test):**

C#

```
// ... inside foreach (MobileUnit mu in assets)
if (mu != null && mu.ConfigurationStatus != ConfigurationStatus.NotCommissioned)
{
    // The status setting logic should move AFTER all related template change/reset actions
    // to ensure the final status is the one we intend to persist.
    
    // 1. Perform template resets first (which might internally update configuration status)
    if (eventTemplateChanged)
    {
        await _deviceConfigRepo.ResetAssetMobileUnit(mu.AssetId, ResetType.Events).ConfigureAwait(false);
    }
    
    // NOTE: This ResetType for mobileTemplateChanged looks suspicious, investigate ResetType
    if (mobileTemplateChanged) 
    {
        await _deviceConfigRepo.ResetAssetMobileUnit(mu.AssetId, ResetType.Events).ConfigureAwait(false);
    }
    
    // 2. Re-fetch or re-evaluate the status if it was changed by the resets (optional, but safer)
    // OR: Re-apply the desired status *after* the resets, just before the final save.

    if (forceSetConfigAccepted)
    {
        mu.ConfigurationStatus = ConfigurationStatus.ConfigurationAccepted;
    }
    else
    {
        mu.ConfigurationStatus = ConfigurationStatus.ConfigurationChanged;
    }

    // 3. Persist the final intended status
    await _deviceConfigRepo.UpdateConfigurationStatus(session, mu.Id, mu.ConfigurationStatus).ConfigureAwait(false);
}
// ...
```

By moving the final intended status setting and persistence to the very end of the loop iteration, you ensure that the intended `ConfigurationChanged` status is the last one written to the database, overriding any interim status changes made by the `ResetAssetMobileUnit` call.

