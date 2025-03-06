---
Parent:: [[Command45]]
---

# SR-12041 Send Command 45 via FM Time Asjuster

[[Done]]

  BE | Local | PR INT
  3 API | Local | INT (with common nuget) (22.2) (CR)
  API Utils | Local | INT
  1 Common | Local | INT (22.2)
  x Client | Local | INT 

  https://jira.mixtelematics.com/browse/CR-1264

  Config/MR/SR-12041_Command45_Via_FMTimeAdjuster.22.3.INT_ORIDaylightSavingsCommand

Hi SOC, deploying DeviceConfig API to VIR, SYD, ENT & ZA as per CR-1269



  public const string SendDaylightSavingsCommandToMobileUnits = "daylight-savings"; //groupIds/{groupIds}/mobile-units/{mobileUnitIds}/types/{typeIds}

  public HttpResponseMessage SendDaylightSavingsCommandToMobileUnits(string authToken, [FromBody] DaylightSavingsCommand dstCommand)

  DaylightSavingsCommand
  https://integration.mixtelematics.com/#/fleet-admin/asset/details?id=
  5458996954334640037
  &orgId=
  2364975042774694384

  https://integration.mixtelematics.com/#/fleet-admin/asset/details?id=5458996954334640037&orgId=2364975042774694384

  public const string SendDaylightSavingsCommandToMobileUnits = "groupIds/{groupIds}/mobile-units/{mobileUnitIds}/types/{typeIds}/daylight-savings";

  - IDeviceIntegrationManager (GetAssetIdsThatHaveDeviceAvailableForOrg , UpdateAssetTimezoneDeviation)
  - IGroupManager (GetGroupsForGroupIdList, GetGroupWithMembersById)
  - IOrganisationRepository (GetSites, GetOrganisationSummary)
  - IGroupRepository (GetGroup)
  - IOrganisationGroupManager (GetOrganisationSummaries, GetOrganisationGroupForEntity)