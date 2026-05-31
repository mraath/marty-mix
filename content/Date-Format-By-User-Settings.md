---
wiki_ingested: 2026-05-28
created: 2026-03-06T16:59
updated: 2026-03-06T16:59
---
# Date Format Based on User Settings

## 1. DynaMiX.Backend

The date format lives in the **Globalization** module. Each `DateFormat` entity has a `FormatString` stored in DB via `[DynaMiX_Globalization].[DateFormats_GetList]`.

### Entity

`DynaMiX.Logic/Modules/Globalisation/Entities/DateFormat.cs`

```csharp
public class DateFormat
{
	public int DateFormatId { get; set; }
	public string FormatString { get; set; }  // e.g. "dd/MM/yyyy"
	public string Description { get; set; }
}
```

### Fetching Available Date Formats

`GlobalizationGateway.cs:237`

```csharp
// Via IGlobalizationGateway
GatewayResult<DateFormatListCarrier> result = GlobalizationGateway.GetDateFormats();
// result.Value.DateFormats is a List<DateFormatCarrier>
// each with: DateFormatId, FormatString, Description
```

### Applying It to a Date

`ZonedDateTimeCarrier.cs:39`

```csharp
// ZonedDateTimeCarrier wraps a DateTime + TimeZone info.
// Call ToString(formatString) with the user's chosen format:
string userDateFormat = /* DateFormatCarrier.FormatString for the user's DateFormatId */;
string displayDate = myZonedDateTimeCarrier.ToString(userDateFormat);
// -> "15/03/2025 10:45:00 (SAST)"
```

### Converting for the Client (Mobile API)

`MiXFleet.Mobile.Api/Shared/Carriers/Common/Converter.cs:90`

```csharp
// Extension method pattern used throughout the Mobile API:
DateFormatCarrier carrier = globalizationDateFormatCarrier.ToCarrier();
// carrier.FormatString is what you pass down to the client
```

> **Note:** `UserProfile` stores `LocaleId` (a `CultureInfo` LCID int). The `DateFormat` and `TimeFormat` fields were commented out — the locale drives formatting in most places. The full regional settings bundle is `RegionalSettingsCarrier`, which includes `DateFormats`, `TimeFormats`, `NumberFormats`, `TimeZones`, etc.

---

## 2. MiX.Config.Frangular.UI (Angular)

The format comes from `sessionService.loggedInProfile.locale`, provided by `@mixtel/dynamixframework` (the Fleet Client). It exposes `shortDatePattern` and `shortTimePattern` from the user's profile.

### Building the Format String

`configgroups.component.ts:3902`

```typescript
let dateFormatString: string = "medium"; // Angular default fallback

if (isDateField &&
	this.sessionService.loggedInProfile?.locale?.longDatePattern) {

	// Combine date + time pattern from the user's locale.
	// Note: replace 'tt' -> 'a' converts the .NET AM/PM token to Angular's equivalent.
	dateFormatString = this.sessionService.loggedInProfile.locale.shortDatePattern
		+ " "
		+ this.sessionService.loggedInProfile.locale.shortTimePattern.replace('tt', 'a')
		+ ' (ZZZZ)';
}

// Then assign to the column definition:
this.assetsColumns[i] = {
	field: column.field,
	isDateField: true,
	dateFormatString: dateFormatString,
	// ...
};
```

### Applying It in the Template

`configgroups.component.html:328`

```html
<!-- Angular date pipe receives the format string from the column definition -->
{{ dataItem[col?.field] | date:(col?.dateFormatString) }}
```

### The IColumn Interface

`column.interface.ts`

```typescript
export interface IColumn {
	isDateField?: boolean;
	dateFormatString?: string;  // Angular date pipe format string
	// ...
}
```

---

---

## 3. Use Case — Timeline Text Summary (Backend API)

The `TimelineTextSummary` class is a concrete example of `UserProfile.LocaleId` driving date formatting end-to-end in the API layer.

### Flow

1. **Module receives request** — `TimelineModuleBase.cs:255` constructs a `TimelineTextSummary`, passing `CurrentUserProfile` (sourced from the authenticated session via `MobileApiModuleBase.cs:440`).

2. **Locale is resolved** — At each text-building method (trip depart, trip halt, event start/end), the locale is looked up via:

	`TimelineTextSummary.cs:155`
	```csharp
	var selectedLocale = GlobalizationGateway.GetLocaleById(_userProfile.LocaleId).Value;
	```

3. **`DateFormatConverter` builds a `DateTimeFormatInfo`** — `DateFormatConverter.cs:37`

	```csharp
	// Singleton. Caches LocaleEntryCarrier by LocaleId.
	public string GetRegionalDateFormat(DateTime dat, UserProfile userProfile)
	{
		LocaleEntryCarrier locale = UserLocale.GetOrAdd(
			userProfile.LocaleId,
			CultureSettings.GetLocalCultures().Find(o => o.Id == userProfile.LocaleId));

		var newCulture = new CultureInfo(GetUserProfileLanguage(userProfile.LanguageCode), false);
		newCulture.DateTimeFormat.ShortDatePattern = locale.ShortDatePattern;
		newCulture.DateTimeFormat.LongTimePattern  = locale.LongTimePattern;
		// ... all patterns applied from locale
		return dat.ToString(newCulture.DateTimeFormat);
	}
	```

4. **Date field in trip summary is formatted** — `TimelineTextSummary.cs:218`

	```csharp
	case ClassType.DateTime:
		var dateFormat = DateFormatConverter.Instance.GetRegionalFormatForDate(
			selectedLocale.Id, _userProfile.LanguageCode);
		tripTextSummary.Value = zonedDateTime.DateTime.ToString(
			dateFormat.ShortDatePattern + " " + dateFormat.LongTimePattern)
			+ " (" + zonedDateTime.TimeZoneShortName + ")";
		break;
	```

### Key files

| File | Purpose |
|---|---|
| `Entities/DynaMiX.Entities/Users/UserProfile.cs:15` | Entity — `LocaleId` defaults to `CultureInfo.CurrentCulture.LCID`; `DateFormat`/`TimeFormat` fields are commented out |
| `API/DynaMiX.API/Converters/DateFormatConverter.cs:37` | Singleton converter — maps `UserProfile.LocaleId` → `LocaleEntryCarrier` → `DateTimeFormatInfo` |
| `API/DynaMiX.API/Converters/TimelineTextSummary.cs:155` | Consumer — calls `GetLocaleById(_userProfile.LocaleId)` and `DateFormatConverter` per text block |
| `API/DynaMiX.API/NancyModules/Timeline/TimelineModuleBase.cs:255` | Entry point — passes `CurrentUserProfile` into `TimelineTextSummary` |

> **Note:** `DateFormatConverter` uses `ConcurrentDictionary` to cache locale lookups by `LocaleId`, so the DB/culture resolution only happens once per locale per app lifetime.

---

## Summary

| Layer | Source | Applied Via |
|---|---|---|
| Backend | `UserProfile.LocaleId` → `GlobalizationGateway.GetLocaleById()` → `LocaleEntryCarrier` | `DateFormatConverter.GetRegionalDateFormat()` → `DateTime.ToString(DateTimeFormatInfo)` |
| Frontend | `sessionService.loggedInProfile.locale.shortDatePattern` + `shortTimePattern` | Angular `date` pipe |
