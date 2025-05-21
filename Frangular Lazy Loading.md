---
created: 2025-05-21T16:39
updated: 2025-05-21T16:56
---
> [!Info]
We have a Grid for the Config Groups BETA page that took a LONG time to load.
We then broke things up to first load the basic info that would take like a second.
After this we make more async calls to the BE to get the other, longer taking, columns' values.
We also need to visually indicate that this is happening to the user.
Once done we should display a value.

In order to do this we need a few things

## BE

A client method of sorts to get the data async, from the BE, for the UI to be displayed.
Usually this will call some sort of DB Stored Proc, which will hopefully be optimised.

## FR UI HTML file



## FR UI TS file

In the code, the IColumn is used to specify specific column behaviours.
Also see: [[Kendo Column Customised display]]
One of these would be to set a column for Lazy loading.

The IColumn

```ts
export interface IColumn {
  //...,
  lazy: string,
}
```

Some other variables that indicates state... there are many, but usually per field you only need one.
For instance, when lazy loading line info, we use these two.
One just to indicate it is busy lazy loading.
Two to indicate which ones.

```ts
lazyLoadingLines: boolean = false;
lazyLoadingLinesUnits: string = '';
```

Next setting the actual columns that Lazy Loads
This needs to be one for both the CG Grid and Assets Grid, as both implement the IColumn

```ts
// Columns that lazy loads
  private configGroupColumnLazy: Record<string, string> = {
    "alerts": "cgalerts",
    "flagged": "other",
    "assetsCount": "other",
    "fwVersion": "other",
    "canScript": "other",
    "speed": "other",
    "hos": "other",
    "sp": "other",
    "fuel": "other",
    "rpm": "other",
  }
  private configAssetColumnLazy: Record<string, string> = {
    "alerts": "alerts",
    "fwVersion": "alerts",
    "preferredFWVersion": "alerts",
    "serialnumber": "alerts",
    "commsLog": "alerts",
    "speed": "lines",
    "hos": "lines",
    "miXVisionSerialnumber": "lines",
    "sp": "lines",
    "fuel": "lines",
    "rpm": "lines",
  }
```