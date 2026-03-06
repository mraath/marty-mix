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

## Summary

| Layer | Source | Applied Via |
|---|---|---|
| Backend | `[DynaMiX_Globalization].[DateFormats_GetList]` -> `DateFormat.FormatString` | `ZonedDateTimeCarrier.ToString(formatString)` |
| Frontend | `sessionService.loggedInProfile.locale.shortDatePattern` + `shortTimePattern` | Angular `date` pipe |
