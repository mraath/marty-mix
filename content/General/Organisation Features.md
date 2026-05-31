---
wiki_ingested: 2026-05-28
created: 2026-01-28T07:14
updated: 2026-01-28T07:17
---
## Eg

- BE: https://dev.azure.com/MiXTelematics/Common/_git/DynaMiX.Backend/pullrequest/137619?_a=files
- FE: https://dev.azure.com/MiXTelematics/Common/_git/MiX.Fleet.UI/pullrequest/137618?_a=files

## Snippets

EG: **configReview**

### BE

```c#
GeneralFeatureCarrier.cs
+1
/API/DynaMiX.API/Carriers/Operations/OrgSettings/GeneralFeatureCarrier.cs
View
	{
		public GeneralFeature IftaCheckbox { get; set; }
		public GeneralFeature MiXTalk { get; set; }
		public GeneralFeature ConfigReview { get; set; }
		public GeneralFeature TripClassification { get; set; }
		public List<string> SubscriptionContacts { get; set; }
		public bool UsDataCenter { get; set; }

GeneralFeaturesModule.cs
-1+21
/API/DynaMiX.API/NancyModules/Operations/OrgSettings/GeneralFeaturesModule.cs
View
				Permissions.ORG_SETTINGS_ACCESS_IFTA_STATE_LINE_CROSSING_FEATURE,
				Permissions.ORG_SETTINGS_UPDATE_IFTA_STATE_LINE_CROSSING_FEATURE,
				Permissions.ORG_SETTINGS_ACCESS_MIX_TALK_FEATURE,
				Permissions.ORG_SETTINGS_UPDATE_MIX_TALK_FEATURE
				Permissions.ORG_SETTINGS_UPDATE_MIX_TALK_FEATURE,
				Permissions.ORG_SETTINGS_ACCESS_CONFIG_REVIEW_FEATURE,
				Permissions.ORG_SETTINGS_UPDATE_CONFIG_REVIEW_FEATURE
			};
			Dictionary<long, bool> permissionAccess = AuthorisationManager.Authorise(authToken, permissionIds, orgId);
			bool canAccessMiXTalk = permissionAccess[Permissions.ORG_SETTINGS_ACCESS_MIX_TALK_FEATURE];
			bool canUpdateMiXTalk = permissionAccess[Permissions.ORG_SETTINGS_UPDATE_MIX_TALK_FEATURE];
			bool canAccessConfigReview = permissionAccess[Permissions.ORG_SETTINGS_ACCESS_CONFIG_REVIEW_FEATURE];
			bool canUpdateConfigReview = permissionAccess[Permissions.ORG_SETTINGS_UPDATE_CONFIG_REVIEW_FEATURE];
			carrier.UsDataCenter = false;
			if (FeatureHelper.FeatureEnabled(UIFeatures.IFTASubscriptions))
				carrier.UsDataCenter = true;
				Enabled = orgDetail.HasFeature(OrgFeature.MiXTalk)
			};
			carrier.ConfigReview = new GeneralFeature
			{
				Access = canAccessConfigReview,
				Update = canUpdateConfigReview,
				Enabled = orgDetail.HasFeature(OrgFeature.ConfigReview)
			};
			carrier.SubscriptionContacts = new List<string>();
			if (carrier.IftaCheckbox.Enabled)
			{
					currentFeatures.Add(OrgFeature.MiXTalk);
			}
			if (orgDetail.HasFeature(OrgFeature.ConfigReview) != updateCarrier.ConfigReview.Enabled)
			{
				if (updateCarrier.ConfigReview.Enabled)
					targetFeatures.Add(OrgFeature.ConfigReview);
				else
					currentFeatures.Add(OrgFeature.ConfigReview);
			}
			if (updateCarrier.TripClassification != null && orgDetail.HasFeature(OrgFeature.TripClassification) != updateCarrier.TripClassification.Enabled)
			{
				if (updateCarrier.TripClassification.Enabled)

Permissions.cs
+3
/Common/DynaMiX.Common/Operations/Permissions.cs
View
		
		public const long ORG_SETTINGS_ACCESS_EVENT_ANALYSER_SETTINGS_FEATURE = 800001304;
		public const long ORG_SETTINGS_UPDATE_EVENT_ANALYSER_SETTINGS_FEATURE = 800001301;
		public const long ORG_SETTINGS_ACCESS_CONFIG_REVIEW_FEATURE = 800001305;
		public const long ORG_SETTINGS_UPDATE_CONFIG_REVIEW_FEATURE = 800001306;
	}
	public class OperationsPermissionGroupTypeRestrictions : PermissionGroupTypeRestrictions

Operations.cs
+6
/Common/DynaMiX.Common/PermissionModules/Definitions/Operations.cs
View
					AccessPermissionId = Permissions.ORG_SETTINGS_ACCESS_EVENT_ANALYSER_SETTINGS_FEATURE,
					UpdatePermissionId = Permissions.ORG_SETTINGS_UPDATE_EVENT_ANALYSER_SETTINGS_FEATURE
				},
				new PermissionModuleFeature
				{
					Name = "Organisation settings - Config Review",
					AccessPermissionId = Permissions.ORG_SETTINGS_ACCESS_CONFIG_REVIEW_FEATURE,
					UpdatePermissionId = Permissions.ORG_SETTINGS_UPDATE_CONFIG_REVIEW_FEATURE
				},
			};
		}
	}

OrganisationFeature.cs
-1+2
/Entities/DynaMiX.Entities/Operations/OrganisationFeature.cs
View
		TransportCertificationAustralia,
		MyMiXEasyCheck,
		IFTA,
		StateMiles
		StateMiles,
		ConfigReview
	}
	public static class OrgFeatures
```

### FE

```c#
OrganisationFeatures.ts
+1
/UI/Js/Operations/Controllers/OrganisationSettings/OrganisationFeatures.ts
View
	export interface IPageData {
		iftaCheckbox: IOrganisationFeature;
		mixTalk: IOrganisationFeature;
		configReview: IOrganisationFeature;
		tripClassification: IOrganisationFeature;
		subscriptionContacts: string[];
		selectedContacts: any[];

GeneralOrganisationFeatures.html
+5
/UI/Js/Operations/Templates/OrganisationSettings/GeneralOrganisationFeatures.html
View
					<span dmx-translate>MiX Talk</span>
				</label>
				<label class="checkbox" ng-show="pageData.configReview.access">
					<input type="checkbox" ng-model="pageData.configReview.enabled" ng-disabled="!pageData.configReview.update" ng-change="$controller.orgFeatureChanged()" />
					<span dmx-translate>Config Reviews</span>
				</label>
				<label class="checkbox" ng-show="pageData.iftaCheckbox.access && pageData.usDataCenter">
					<input type="checkbox" ng-model="pageData.iftaCheckbox.enabled" ng-disabled="!pageData.iftaCheckbox.update" ng-change="$controller.orgFeatureChanged()" />
					<span>
```