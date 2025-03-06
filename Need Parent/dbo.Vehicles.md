## Links

- **Sites**: dbo.Vehicles (liSiteID) [[dbo.Sites]]

- We get the **AssetDB name** from this:
	(sConnectDatabase) in
	[[FMOnlineDB .dbo.Organisation]] (liOrgID = legacyOrgId) [[mobileunit. AssetMobileUnit]]
	
- We connect to **AssetMobileUnit** via FMOnlineDB (sConnectDatabase)
	  dbo.Vehicles (iVehicleID = legacyVehicleId) [[mobileunit. AssetMobileUnit]]

Friend: #table