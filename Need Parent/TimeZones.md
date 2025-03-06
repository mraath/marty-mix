---
created: 2023-09-22T16:01
updated: 2024-05-09T16:46
---

[Yesterday 15:42] Marthinus Raath

Hey ou - ek hoop jy doen OK

Ek gaan net n vraag stuur en dan eers weer more kyk na die ![🙂](https://statics.teams.cdn.office.net/evergreen-assets/personal-expressions/v2/assets/emoticons/smile/default/20_f.png "Smile")

Maar wou gou weet - vir ons nuwe frangular goed moet ek die timezone dinge doen.

Wat gebruik jul vir die volgende calls wat ons in die BE gedoen het...

- orgManager.GetAssetDataTimeZone
- timeZoneManager.GetTimeZoneHistoryForAssets
- mobileDateTime.ToHistoricalTimeZone(assetId, timezoneResource, sourceDataTimezone)

Ek is baie naby om dit als in ons API in te pull en te code - maar dink, dit moet seker al gebeur... iewers... ![🙂](https://statics.teams.cdn.office.net/evergreen-assets/personal-expressions/v2/assets/emoticons/smile/default/20_f.png "Smile") 

```txt
DONE: var x = Fleet.Services.FleetAdmin.Logic.AssetDetailsManager.GetAssetHistoricalSiteTimeZoneList ...
Fleet.Services.FleetAdmin.Common.Helpers.TimeZoneHelper.ToHistoricalTimeZone ... x <<<<<<< write this in our own API
```

[Yesterday 16:03] Timothy Butler

Hi, ek doen heel okay, hoop jy is ook okay ![🙂](https://statics.teams.cdn.office.net/evergreen-assets/personal-expressions/v2/assets/emoticons/smile/default/20_f.png "Smile")

- Ons gee nie om oor GetAssetDataTimeZone nie omdat meeste van die data waaroor ons omgee is nou UTC. Vir daai gebruik net die Fleet.Services se OrganisationClient en kry die OrganisationDetails
- Daarvoor gebruik ons Fleet.Services ook  
    

![[TimeZones Fleet part 1.png]]

- Ons gebruik vorige result en framework  

![[Pasted image 20240509121651.png]]
