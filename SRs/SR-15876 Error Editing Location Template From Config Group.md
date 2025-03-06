---
status: closed
date: 2023-07-25
comment: 
priority: 8
---

# SR-15876 Error Editing Location Template From Config Group

Date: 2023-07-25 Time: 08:20
Parent:: [[Location Template]]
Friend:: [[2023-07-25]]
JIRA:SR-15876 Error Editing Location Template From Config Group
[SR-15876 UK: Error when accessing the Location Template - Jira (atlassian.net)](https://csojiramixtelematics.atlassian.net/browse/SR-15876)



```dataviewjs
function callout(text, type) {
    const allText = `> [!${type}]\n` + text;
    const lines = allText.split('\n');
    return lines.join('\n> ') + '\n'
}

const query = `
not done
path includes ${dv.current().file.path}
# you can add any number of extra Tasks instructions, for example:
# group by heading
`;

dv.paragraph(callout('```tasks\n' + query + '\n```', 'todo'));
```

## Branch

- SR-15876 Error Editing Location Template From Config Group.INT.ORI
- ALWAYS merge INT back in before merging to DEV, then INT...

## Testing notes

- What to test
- Passed or failed with images

## Description

- errors when trying to access the 'Locations Template” under the configurations Tab
	- Click on Asset
		- Click on Location Templates
	- 1420123322872893440, 1420127199852630016
		- Log: https://app.logz.io/#/goto/ebd26736e590fc2116063be25b1f2e5c?switchToAccountId=157279
		- _EXCEPTION_! The given key was not present in the dictionary.
			- This refers to the code trying to find a value within a dictionary but it couldn't
			- From that code the only dictionary points to: dictMapLocationSummaries, which is built up from mapLocationSummaries
			- The mapLocationSummaries is pulled from: mapLocationManager.GetMapLocationSummaries
			- Were any locations maybe deleted which caused this?
			- I will continue looking at the code for a while...
		- <RequestUrl>GET http://uk.mixtelematics.com:80/DynaMiX.API/config-admin/organisations/3920582751198253206/assets/-8395350895723227642/locations</RequestUrl>
		- <RequestUrl>GET http://uk.mixtelematics.com:80/DynaMiX.API/config-admin/organisations/3920582751198253206/assets/-3499788942891519698/locations</RequestUrl>
			- ConfigAdmin.MobileUnitLevel.MobileUnitLocationTemplatesModule.GetLocationTemplate
			- ConfigAdmin\MobileUnitLevel\MobileUnitLocationTemplates.cs:_line_ 97
		- Code ??:
			- GET_LOCATIONS
			- /organisations/{orgId}/assets/{assetId}/locations
			- GetLocationTemplate
				- LocationTemplateManager.GetLocationTemplateAggregate
				- ConfigAdminRepository.GetLocationTemplateWithChildrenById
			- Checking out 23.10 to see whats on line 97
				- GET: **locationTemplate.TemplateLocations**
					- Need: configGroup.LocationTemplateId
					- Search AssetID: A208AP83, Config Group: <div class="cell alt" row="0">FM37x7i - HV - GPSV &amp; RPM - GLNS RX - HL&gt;6V - APN "internet.mts.ru"</div>
						- ConfigurationGroupKey: 3225
						- MobileDeviceTemplateKey: 3069
						- EventTemplateKey: 1912
						- LibraryKey: 402
						- LocationTemplateKey: 20
				- GET: **dictMapLocationSummaries**
					- Achmat and Tim
					- 
				- TRY: dictMapLocationSummaries[templateLocation.DmxLocationId]
				- <mark class="hltr-red">I'm sure this is where it fails:</mark>
					- UI: Template Location return 232 line
					- SQL: Return 236 (could be my sql, shouldn't be)
					- This seems to show 4 deleted (which could explain the Dictionary error)
						- Didn't we add logic in another issue to not include softdeleted
						- Shouldn't this be added to the CG edit location template logic?
						- Could it be the legacy path with lightning map locations
## SQL to get Locations

```sql
USE DeviceConfiguration;
DECLARE @GroupId BIGINT = 3920582751198253206;


Select * FROM library.libraries WHERE GroupID = @GroupId


DECLARE @lorgID INT = (SELECT OrganisationId
FROM FMOnlineDB.dynamix.Organisations
WHERE GroupId = @GroupId)

SELECT sConnectDatabase, liGMTOffset, *
FROM FMOnlineDB.dbo.Organisation dboOrg
WHERE dboOrg.liOrgID = @lorgID

-- Configuration Library of MiX Brazil Testing

-- Try to get more ConfigGroup Info
USE DeviceConfiguration;
Select top 10 * FROM template.ConfigurationGroups Where LibraryKey = 402 AND Name like 'FM37x7i - HV - GPSV & RPM - GLNS RX - HL>6V - APN "internet.mts.ru"'

-- Got Location Template
Select top 10 * FROM template.LocationTemplates WHERE LocationTemplateKey = 20

-- Get TemplateLocations
Select lloc.DmxLocationId, * from template.Locations tloc
JOIN library.Locations lloc on lloc.LibraryLocationKey = tloc.LibraryLocationKey
WHERE LocationTemplateKey = 20 


--
```

## Issue Info

```txt
IDC: UK  
Org: Schlumberger-RCA-RUL  
DB: SCHLUMBERGERRCA_2014  
Org ID: 3858  
64 Bit Org ID: 3920582751198253206
```
- GET https://uk.mixtelematics.com/DynaMiX.API/config-admin/organisations/3920582751198253206/assets/-3838074843355898688/locations 500 (Internal Server Error)


## Locations from UI

| Location                                                           | Location type |     |
| ------------------------------------------------------------------ | ------------- | --- |
| JM SPEED ZONE - 60 KMH - PANGODY                                   | Other         |     |
| JM Zone - Achimgaz field - 40 km/h                                 | Other         |     |
| JM Zone - Aganskoe field – 40 kph                                  | Speed zone    |     |
| JM Zone - Arlan bush 2133 - 40km/h                                 | Other         |     |
| JM Zone - Arlansky 11520 - 40km/h                                  | Other         |     |
| JM Zone - Beregovoe field - 40 km/h                                | Speed zone    |     |
| JM Zone - Chayandinskoye field - 50 kmh                            | Speed zone    |     |
| JM Zone - Chetyrmanskoe 1312 - 40km/h                              | Other         |     |
| JM Zone - Demyansk Station - 60 kmh - 2022                         | Speed zone    |     |
| JM Zone - Dorokhovskoe field - 40 kmh                              | Speed zone    |     |
| JM Zone - Dudinka - 60 kmh                                         | Other         |     |
| JM Zone - East Tazovskoe Field - 40 km/h                           | Other         |     |
| JM Zone - Ety Purovskoe fled                                       | Speed zone    |     |
| JM Zone - Gaz-Sale village - 60 km/h                               | Speed zone    |     |
| JM Zone - Igolsko-Talovoe field - 60 kmh                           | Other         |     |
| JM Zone - Igrovskoe 6707 - 40km/h                                  | Other         |     |
| JM Zone - Kamennoe field 2 - 40 kmh                                | Other         |     |
| JM Zone - Kapitinovskoe - 40km/h                                   | Other         |     |
| JM Zone - Kasibskoe field - 40 kmh                                 | Speed zone    |     |
| JM Zone - Kechimovskoye Field -Speed-limit 40km-h                  | Other         |     |
| JM Zone - Khokhryakovsoye oilfield - 60 km/h                       | Speed zone    |     |
| JM Zone - Korotchaevo town - 60 km/h                               | Speed zone    |     |
| JM Zone - Langepas town 60 kmph                                    | Speed zone    |     |
| JM Zone - Machchobinskoe oilfield 40 kmh                           | Other         |     |
| JM Zone - Mancharovskoye - 40km/h                                  | Other         |     |
| JM Zone - Mirny - 60km/h                                           | Other         |     |
| JM Zone - New Mayskoe - 40km/h                                     | Customer      |     |
| JM Zone - Nivagalskoe field 2 40 kmph                              | Speed zone    |     |
| JM Zone - Nivagalskoe field 40 kmph                                | Speed zone    |     |
| JM Zone - Novy Port oilfield - 40 km/h                             | Other         |     |
| JM Zone - Orebashevskoe - 40km/h                                   | Other         |     |
| JM Zone - Pokachi town 60 kmph                                     | Speed zone    |     |
| JM Zone - Potochnoe field 40 kmph                                  | Speed zone    |     |
| JM Zone - Potochnoe field2 40 kmph                                 | Speed zone    |     |
| JM Zone - Purovsk - 60 km/h                                        | Other         |     |
| JM Zone - Raduzhny - 60 kmh                                        | Other         |     |
| JM Zone - Russkoe field - 40 kmh                                   | Other         |     |
| JM Zone - Semakovskoe- oilfield - 40 km/h                          | Speed zone    |     |
| JM Zone - Severo-Danilovskoe oilfield 60kmph (40)                  | Other         |     |
| JM Zone - Severo-Potochnoe field 40 kmph                           | Speed zone    |     |
| JM Zone - Severo-Talakanskoe field - 40 kmh                        | Other         |     |
| JM Zone - Sporyshevskoe oilfield 2.1 - 40 km/h                     | Customer      |     |
| JM Zone - Sporyshevskoe oilfield 2.2 - 40 km/h                     | Customer      |     |
| JM Zone - Sredne-Iturskoe oilfield - 40 km/h                       | Customer      |     |
| JM Zone - Srednebotuobinskoe oilfield RNG - 40km/h                 | Other         |     |
| JM Zone - Stary Urengoy - 60 km/h                                  | Speed zone    |     |
| JM Zone - Suzun field - 40 kmh                                     | Other         |     |
| JM Zone - Tagul field - 40km/h                                     | Other         |     |
| JM Zone - Talakan - 40 kmh                                         | Other         |     |
| JM Zone - Tambey - 40 km/h                                         | Customer      |     |
| JM Zone - Tarko-Sale - 60 km/h                                     | Other         |     |
| JM Zone - Trebsa-Titova - 40km/hr                                  | Other         |     |
| JM Zone - TYNGD Field - 40 km/h                                    | Other         |     |
| JM Zone - Urievskoe field2 40 kmph                                 | Speed zone    |     |
| JM Zone - Urmanskoye field - 40kmh                                 | Other         |     |
| JM Zone - Valyntoyskoe fled                                        | Speed zone    |     |
| JM Zone - Vankor - 40 kmh                                          | Other         |     |
| JM Zone - VCNG field - 40 HV/ 60 LV                                | Other         |     |
| JM Zone - Vostochno-Pridorozhnoe field 40 kmph                     | Speed zone    |     |
| JM Zone - VU ONGKM - 40km/h                                        | Speed zone    |     |
| JM Zone - Vyngapurovskoe oilfield 4.3 - 40 km/h                    | Customer      |     |
| JM Zone - Vyngapurovsky - 60 km/h                                  | Other         |     |
| JM Zone - Vyngayakhinskoe fled                                     | Speed zone    |     |
| JM zone - Yaraktinskoe field - 50 kmh                              | Other         |     |
| JM Zone - Yaraynerskoe oilfield - 40 km/h                          | Customer      |     |
| JM Zone - Yrubcheno - Tokhomskoe Field - 40 km/h                   | Other         |     |
| JM Zone - Yuzhniy Yagun (A) - 40 km/h                              | Speed zone    |     |
| JM Zone - Yuzhniy Yagun (B) - 40 km/h                              | Speed zone    |     |
| JM Zone - Zapadno-Noyabrskoe oilfield 2.1 - 40 km/h                | Customer      |     |
| JM Zone - Zapadno-Seyakhinskoe field - 40 Kmh                      | Customer      |     |
| JM Zone - Zapadno-Tarkosalinskoye field - 40 km/h                  | Other         |     |
| JM Zone - ZMLU oil field - 40 km/h                                 | Other         |     |
| JM Zone and Speed Zone En-Yakhinskoe field 40kph                   | Speed zone    |     |
| JM Zone and Speed Zone Tazovskoe oilfled - 40 km/h                 | Speed zone    |     |
| JM Zone and Speed Zone Yamburgskoe field 40 km / h                 | Other         |     |
| JM Zone Bolshetirskoe oilfield - HV 60 kmh - LV 40 kmh             | Other         |     |
| JM Zone Kovykta - 50 HV 40 LV                                      | Speed zone    |     |
| JM Zone Krapivenskoe field - 60/40 RSB - Strezhevoy - AL kmh       | Other         |     |
| JM Zone Kuyumbinskiy oilfield - 40 kmh                             | Other         |     |
| JM Zone Lensk 60 kph                                               | Other         |     |
| JM Zone Markovo oilfield - HV 60kph - LV 40kph                     | Customer      |     |
| JM Zone Naryan-Mar                                                 | Other         |     |
| JM Zone Palyanovskoe field - 40 kmh                                | Speed zone    |     |
| JM Zone Poykovo town - 60 km/h                                     | Other         |     |
| JM Zone Severo-Komsomolskoe field 40 kmh                           | Other         |     |
| JM Zone Verhnetirskoe - Ichedinskoe oilfield - HV 60kmh / LV 50kmh | Speed zone    |     |
| JM Zone Vostok Oil speed limit 40 kmh                              | Speed zone    |     |
| JM Zone – Kharyaga field - 60 kmh                                  | Speed zone    |     |
| JM Zone-Urengoyskoe NGKM - 40 kmh                                  | Other         |     |
| JM-ZONE -3Urievskoe field speed limit 40kmh                        | Speed zone    |     |
| JM-ZONE Erginskoe field-2020 - 40km/hr                             | Customer      |     |
| JM-ZONE- 1Yuzhno-Pokachevskoe field speed limit 40kmh              | Speed zone    |     |
| JM-ZONE-1 Urievskoe field-Speed limit 40 kmh                       | Speed zone    |     |
| JM-ZONE-2Urievskoe field speed limit 40 kmh                        | Speed zone    |     |
| JM-ZONE-2Yuzhno-Pokahevskoe field speed limit 40kmh                | Speed zone    |     |
| JMZone - Gubkinsky-Purpe Non-Field                                 | Other         |     |
| JMZone - Luginetskoye field- 40kmh                                 | Other         |     |
| JMZone - NULU oilfield - 40 km/h                                   | Customer      |     |
| JMZone - Pionerny - 60 km/h                                        | Other         |     |
| JMZone - Ust Kut Town - 60km/h                                     | Other         |     |
| New JM-Zone Shinginskoe field Speed ​​limit 40kmh                  | Other         |     |
| Speed Zone - 40 kmh - New Lapti                                    | Other         |     |
| Speed Zone - Aspinskoe field - 40 kmh                              | Speed zone    |     |
| Speed Zone - Chupalskoe field - 40kmh                              | Speed zone    |     |
| Speed Zone - East - Surgutskoe field 2021 - 40km/hr                | Other         |     |
| Speed Zone - East Surgut Field -Speed-limit 40km-h                 | Other         |     |
| Speed Zone - Ferma - 60 kmh                                        | Other         |     |
| Speed Zone - Gryazi - 60 kmh                                       | Customer      |     |
| Speed Zone - Gubkinsky - 60 kmh                                    | Speed zone    |     |
| Speed Zone - Irkutsk - 60 km/h                                     | Other         |     |
| Speed zone - Kalchinskoe field - 40 kmh (2021)                     | Speed zone    |     |
| Speed Zone - Kamennoe field 1 - 40 kmh - 2022                      | Other         |     |
| Speed Zone - Kapkanskoe field - 40 kmh                             | Speed zone    |     |
| Speed Zone - Krasnoyarsk - 60 kmh                                  | Other         |     |
| Speed Zone - Kraynee field - 40 kmh                                | Speed zone    |     |
| Speed Zone - Lesnoe field - 40 kmh                                 | Speed zone    |     |
| Speed Zone - Levinskoe field - 40 kmh                              | Speed zone    |     |
| Speed Zone - Lipetsk - 60 kmh                                      | Customer      |     |
| Speed Zone - Lyantor-Sredne - Nazymskoe field - 70 kmh - 2021      | Other         |     |
| Speed Zone - Muravlenkovskoe field 1 - 40 kmh                      | Customer      |     |
| Speed Zone - Muravlenkovskoe field 2 - 40 kmh                      | Customer      |     |
| Speed Zone - Neftekamsk 60kph                                      | Speed zone    |     |
| Speed Zone - Nizhnevartovsk - 60 kmh                               | Other         |     |
| Speed Zone - North Island Field -Speed-limit 40km-h                | Other         |     |
| Speed zone - North Khokhryakovskoye field 40kmh                    | Speed zone    |     |
| Speed Zone - Nyagan - 60 kmh                                       | Other         |     |
| Speed Zone - Orenburg - 60 kmh                                     | Other         |     |
| Speed zone - Osa - 60 kmh                                          | Speed zone    |     |
| Speed Zone - Perm - 60 kmh                                         | Other         |     |
| Speed Zone - Prirazlomnoe field 1 - 40 kmh                         | Other         |     |
| Speed Zone - Purpe - 60 kmh                                        | Speed zone    |     |
| Speed Zone - Road Ust-Teguss - Nizhnevartovsk (1) - 60/80          | Other         |     |
| Speed Zone - Road Ust-Teguss - Nizhnevartovsk (2) - 60/80          | Other         |     |
| Speed Zone - Road Ust-Teguss - Nizhnevartovsk (3) - 60/80          | Other         |     |
| Speed Zone - Road Ust-Teguss - Nizhnevartovsk (4) - 60/80          | Other         |     |
| Speed Zone - Romanovskoe field - 40 kmh                            | Speed zone    |     |
| Speed Zone - Rospan VULU and Arktikgaz - 40 kmh                    | Other         |     |
| Speed zone - Rospan VULU and Arktikgaz - 60 kmh                    | Other         |     |
| Speed Zone - Samara - 60 kmh                                       | Speed zone    |     |
| Speed Zone - Samotlorskoe field - 40kmh                            | Other         |     |
| Speed Zone - Samotlorskoe field-2 – 40kmh                          | Other         |     |
| Speed Zone - Sosnovskoe field - 40 kmh                             | Speed zone    |     |
| Speed Zone - South Priobskoe field 1 - 40 kmh                      | Speed zone    |     |
| Speed Zone - South Priobskoe field 2 - 40 kmh                      | Speed zone    |     |
| Speed Zone - South Priobskoe field 3 - 40 kmh                      | Speed zone    |     |
| Speed Zone - South Priobskoe field 4 - 40 kmh                      | Speed zone    |     |
| Speed Zone - South Surgut Field -Speed-limit 40km-h                | Other         |     |
| Speed Zone - SPD field zone SLB 40 kmph                            | Speed zone    |     |
| Speed Zone - Sterlitamak- 60 kmh                                   | Speed zone    |     |
| Speed Zone - Street Magistralnaya - 40 km/h                        | Other         |     |
| Speed zone - Strezhevoy - 60 kmh                                   | Other         |     |
| Speed Zone - Sugmutskoe field - 40 kmh                             | Customer      |     |
| Speed zone - Suslikovskoe field 40kmh                              | Speed zone    |     |
| Speed Zone - Sutorminskoe field 1 - 40 kmh                         | Customer      |     |
| Speed Zone - Sutorminskoe field 2 - 40 kmh                         | Customer      |     |
| Speed Zone - Talinka village - 60 kmh                              | Other         |     |
| Speed Zone - Talinskoe field 3 - 40 kmh                            | Other         |     |
| Speed Zone - Tashla - 60 km/h                                      | Speed zone    |     |
| Speed Zone - Tyumen STC - 30 kmh                                   | Customer      |     |
| Speed Zone - Van Eganskoe field - 40 kmh                           | Other         |     |
| Speed Zone - Van Eganskoe field - 60 kmh                           | Other         |     |
| Speed zone - Var-Yeganskoe 40kmh                                   | Speed zone    |     |
| Speed Zone - VerkhnekolvinskBase - 20kmh                           | Other         |     |
| Speed Zone - Vyngayakhinskoe and Valyntoyskoe fleds - 40 kph       | Speed zone    |     |
| Speed Zone - West Varioganskoye Field -Speed-limit 40km-h          | Other         |     |
| Speed Zone - Zaytseva Rechka - 60 km/h                             | Speed zone    |     |
| Speed Zone - Zhagrinskoe field - 40km/h                            | Speed zone    |     |
| Speed Zone -Road. Srednebalykskoe field KHMAO 40kmh (1)            | Speed zone    |     |
| Speed Zone -Road. Srednebalykskoe field KHMAO 40kmh (2)            | Speed zone    |     |
| Speed Zone from VChNG to SDM - 55 kmh                              | Customer      |     |
| Speed Zone Karamovskoe oilfield 3.1 - 40 km/h                      | Customer      |     |
| Speed Zone Karamovskoe oilfield 3.2 - 40 km/h                      | Customer      |     |
| Speed Zone Karamovskoe oilfield 3.3 - 40 km/h                      | Customer      |     |
| Speed Zone Kholmogorskoe oilfield 2.1 - 40 km/h                    | Customer      |     |
| Speed Zone Kholmogorskoe oilfield 2.2 - 40 km/h                    | Customer      |     |
| Speed Zone Pogranichnoe oilfield 3.1 - 40 km/h                     | Customer      |     |
| Speed Zone Pogranichnoe oilfield 3.2 - 40 km/h                     | Customer      |     |
| Speed Zone Pogranichnoe oilfield 3.3 - 40 km/h                     | Customer      |     |
| Speed Zone Solnichiy base 10kmh                                    | Speed zone    |     |
| Speed Zone Talinskoe field 1 - 40 kmh                              | Other         |     |
| Speed Zone Tatyshlinskoe field - 40 km/h                           | Speed zone    |     |
| Speed Zone Tevlinsko Russkinskoye Field - 40 km/h Part1            | Customer      |     |
| Speed Zone Tevlinsko Russkinskoye Field - 40 km/h Part3            | Customer      |     |
| Speed Zone Tevlinsko Russkinskoye Field - 40 km/h Part4            | Customer      |     |
| Speed Zone Ufa - 60 kmh                                            | Other         |     |
| Speed Zone Vyngapurovskoe oilfield 4.1 - 40 km/h                   | Customer      |     |
| Speed Zone Vyngapurovskoe oilfield 4.2 - 40 km/h                   | Customer      |     |
| Speed zone Vyngapurovskoe oilfield 4.4 - 40 km/h                   | Customer      |     |
| Speed zone Zapadno-Noyabrskoe oilfield 2.2 - 40 km/h               | Customer      |     |
| Speed Zone Zhayanda Main Road - 70kmh                              | Speed zone    |     |
| Speed Zone – Priobskoe field – 40 kmh - 2021                       | Customer      |     |
| Speed Zone – RTP – 60 kmh                                          | Speed zone    |     |
| Speed Zone-IskateleyBase-10kmh                                     | Other         |     |
| Speed Zone-Promyshlennaya 12b(Usinsk)-10kmh                        | Other         |     |
| Speed Zone-Transportnaya46Base-10kmh                               | Other         |     |
| Speed-Zone - Pyt Yakh(2019) - 60 kmh (1)                           | Speed zone    |     |
| Speed-Zone - Pyt Yakh(2019) - 60 kmh (2)                           | Speed zone    |     |
| Speed-Zone - Pyt Yakh(2019) - 60 kmh (3)                           | Speed zone    |     |
| Speed-Zone - Pyt Yakh(2019) - 60 kmh (4)                           | Speed zone    |     |
| Speed-Zone 40 kmh Kondinskoe field-2021                            | Speed zone    |     |
| Speed-Zone 40 kmh Pyt-Yakh                                         | Speed zone    |     |
| Speed-Zone Ust-Tegusskoe field 40kmh                               | Speed zone    |     |
| Speed-Zone- 40 km - Radonezhskoe field-2021                        | Other         |     |
| SpeedZone - Aganskoe road 60 kmph                                  | Speed zone    |     |
| SpeedZone - Aganskoe road2 60 kmph                                 | Speed zone    |     |
| SpeedZone - Buzuluk - 60 km/h                                      | Customer      |     |
| SpeedZone - Khanty Mansiysk - 60 km/h                              | Customer      |     |
| SpeedZone - Kogalym - 60 km/h                                      | Customer      |     |
| SpeedZone - Megion 60 km/h                                         | Other         |     |
| SpeedZone - Muravlenko - 60 km/h                                   | Customer      |     |
| SpeedZone - Nefteyugansk - 60 km/h                                 | Customer      |     |
| SpeedZone - Nizhnevartovsk-Megion-Samotrolskoe Field - 60 km/h     | Other         |     |
| SpeedZone - Novy Urengoy - 60 km/h                                 | Customer      |     |
| SpeedZone - Noyabrsk - 60 km/h                                     | Customer      |     |
| SpeedZone - Priobskoe Road - 60 km/h                               | Customer      |     |
| SpeedZone - Samsonovka - 40 kph                                    | Speed zone    |     |
| SpeedZone - SPD BL SLB 20 kmPh                                     | Speed zone    |     |
| SpeedZone - SPD CPF - 20 km/h                                      | Other         |     |
| SpeedZone - SPD G/5 - 20 km/h                                      | Other         |     |
| SpeedZone - SPD KP 10 kmh                                          | Other         |     |
| SpeedZone - SPD YuTPS SLB 20 kmph                                  | Speed zone    |     |
| SpeedZone - Surgut - 60 km/h revised                               | Other         |     |
| SpeedZone - Tevlinsko Russkinskoye Field - 60 km/h -2020           | Speed zone    |     |
| SpeedZone - Usinsk - 60 km/h                                       | Customer      |     |
| SpeedZone - VU ONGKM - 70 km/h                                     | Other         |     |
| SpeedZone Kharyaga 1 - 40 kmh                                      | Other         |     |
| SpeedZone Kharyaga 2 - 40 kmh                                      | Other         |     |
| SpeedZone Kharyaga 3 - 40 kmh                                      | Other         |     |
| SpeedZone Pyt-Yakh - 15 kmh                                        | Other         |     |
| SpeedZone-Base Noyabrsk-15kph                                      | Other         |     |
| SpeedZone-Novy Urengoy SLI base-15kph                              | Other         |     |
| XXX To be deleted - Ticket(399090)- Duplicate                      | Customer      |     |
|                                                                    |               |     |

## Notes

When investigating the error that occurs when trying to access the 'Locations Template” under the configurations Tab, I found that the exception in all cases (I could also reproduce this), was "The given key was not present in the dictionary."
This means the value it is trying to find within the dictionary is not found.
In that part of code it refers to the Location Summaries for this org doesn't have a value which the Template Locations is trying to lookup.
This is most likely data related (a location was deleted), however, I will continue investigating the code for a bit.


## Zonika has a potential cleanup script

```sql
?????????????????
```