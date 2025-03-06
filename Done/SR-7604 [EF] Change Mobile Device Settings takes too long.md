# SR-7604 [EF] Change Mobile Device Settings takes too long

  BE: Local


  Config/MR/Bug/SR-7604_SlowCommissioningUpdate_20.16.UAT.ORI
  OLD:Config/MR/Bug/SR-7604_ManySpeedIssues_20.16.UAT.ORI

  - First replace the BIG object with SProc and what is really needed

  GetMobileUnitAggregateQuery

  It builds up a LOT of things just to get back one mobile unit
  I will replace this with a stored proc


  UpdateAssetCommissionInformation
    1) resolvedMobileDevice
      DefinitionDeviceId
      AllPeripheralDevices
      MobileUnitProperties
      AllLogicalDevices
      MobileUnitId
      Id
      

      validation?
      GetMobileDeviceTemplateAggregateQueary


      (how created)
      mobileUnit = ConfigAdminRepository.GetMobileUnitAggregate

        *.include

      GetResolvedMobileDevice(mobileUnit)
        mobileUnit.ConfigurationGroupId >  > .MobileDeviceTemplateId > ConfigAdminRepository.GetMobileDeviceTemplateAggregate

        return Context.MobileDeviceTemplates
          .Include(x => x.AllPeripheralDevices)
          .Include(x => x.AllPeripheralDevices.Select(y => y.Properties))
          .Include(x => x.AllPeripheralDevices.Select(y => y.Parameters))
          .Include(x => x.AllLogicalDevices)
          .Include(x => x.AllLogicalDevices.Select(y => y.Properties))
          .Include(x => x.Properties)
          .Include(x => x.Parameters);

        GetResolvedMobileDevice(mobileUnit, template)
          mobileUnit.OverridenDeviceProperties
          mobileUnit.OverridenDeviceParameters
          mobileUnit.OverridenDevices
          mobileUnit.OverridenPeripheralDevices
          mobileUnit.MobileUnitProperties
          mobileUnit.UniqueIdentifier
          mobileUnit.Id

          rmd.MobileUnitId
          rmd.UnitIdentifier
          rmd.MobileUnitProperties
          rmd.AllPeripheralDevices
          rmd.AllLogicalDevices
          rmd.Parameters
          rmd.Properties          

    2) mobileDevice
      UniqueIdentifierPropertyId
      MobileDeviceId

      (How created)
      ConfigAdminRepository.GetMobileDevice
        MobileDevices.FirstOrDefault(m => m.MobileDeviceId == definitionMobileDeviceId (seems fast enough)


  EF:
  Context.MobileUnits
    .Include(mu => mu.MobileUnitProperties)
    .Include(mu => mu.OverridenDevices)
    .Include(mu => mu.OverridenDeviceParameters)
    .Include(mu => mu.OverridenDeviceProperties)
    .Include(mu => mu.OverridenEvents)
    .Include(mu => mu.OverridenEventActions)
    .Include(mu => mu.OverridenEventConditionThresholds)
    .Include(mu => mu.OverridenPeripheralDevices);

    (3 refs)
    - passed in config groupid
      - We can still use configgroupid, then from that get list of mobileunitids
    - passed in single mobileunitId
      - Can still use list(mobileunitids)
    - passed in list of mobileunitids
      - list works perfect
  
  [mobileunit].[MobileUnit_GetMobileDeviceUniqueIdentifierPropertyId]


  SPROC:

  - We need a sproc that will accept list of mobileunitids... then look them up...
  - 
  - MobileUnits
  - mu.MobileUnitProperties
  - mu.OverridenDevices
  - OverridenDeviceParameters
  - OverridenDeviceProperties
  - OverridenEvents
  - OverridenEventActions
  - OverridenEventConditionThresholds
  - OverridenPeripheralDevices

  - Write a test to compate the outputs of above EF vs SProc

  - Next check the individual methods and see if you can remove unnecessary fields, etc (based on need and UI need)

  - Set IMEI
    - AssetCommissioningManager.UpdateAssetCommissionInformation
      - mobileUnitManager.GetResolvedMobileDevice
        - ConfigAdminRepository.GetMobileUnitAggregate [? What is actually NEEDED in this piece of code]
          - GetMobileUnitAggregateQuery (3 refs)
            - Context.MobileUnits
										.Include(mu => mu.MobileUnitProperties)
										.Include(mu => mu.OverridenDevices)
										.Include(mu => mu.OverridenDeviceParameters)
										.Include(mu => mu.OverridenDeviceProperties)
										.Include(mu => mu.OverridenEvents)
										.Include(mu => mu.OverridenEventActions)
										.Include(mu => mu.OverridenEventConditionThresholds)
										.Include(mu => mu.OverridenPeripheralDevices);
      - GetResolvedMobileDevice
        - ConfigAdminRepository.GetConfigurationGroup (!just to get the MobileDeviceTemplateId)
        - ConfigAdminRepository.GetMobileDeviceTemplateAggregate
          - GetResolvedMobileDevice
          - 
    - ConfigAdminRepository.GetMobileDevice
  - Check all the parts that could be touched
    - Replace EF with SProc
    - Remove unneeded logic
    - Break up the SR into many parts
  - prepare a build with some enhanced _metrics/logging_ so that we can see if this is tied to time of _day_ or specific _environment_
  - This can be deployment to ZA when ready under an investigative CR.

Cascade

