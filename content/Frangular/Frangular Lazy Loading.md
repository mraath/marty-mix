---
created: 2025-05-21T16:39
updated: 2025-05-22T13:25
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

Some other **Additional Variables** that indicates state... there are many, but usually per field you only need one.
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
    "alerts": "cgalerts", //Eg. These load with CGAlerts call (will be an Additional Variable)
    "flagged": "other", //Eg. These load with other call (will be an Additional Variable)
    //.. REST follow, CG has no lines call lazy loading
  }
  private configAssetColumnLazy: Record<string, string> = {
    "alerts": "alerts", //Eg. These load with alerts call (will be an Additional Variable)
    "fwVersion": "alerts", //...same
    "speed": "lines", //Eg. OUR case study, this loads with the lines call (see Additional Vairables above)
    "hos": "lines",
    //..etc
  }
```

Kick off the lazy loading, where you need it. For our example with lazy loading the lines, we do the following.

```ts
//Method to get the asset grid info
getConfigAssets() {
	//...
	this.module.getConfigurationGroupsMultiselectAssetsList //...
	.pipe //...
	.subscribe //.. THIS is what gets git once data gets received from the initial data load
		//... Handle init data
		
		//Lazy Load lines - Call its own backend logic to get SP data
          this.lazyLoadingLines = true;
          this.lazyLoadingLinesUnits = configGroupIds;
          this.module.getConfigurationGroupsMultiselectAssetLinesList({ groupId: this.organisationId }, { configurationGroupIds: configGroupIds })
            .pipe(takeWhile(() => this.alive))
            .subscribe((carrierLines: ConfigurationGroupsMultiselectAssetLinesCarrierList) => {
              if (carrierLines && carrierLines.items) {
                this.UpdateLinesRows(
                  this.allAssets,
                  carrierLines.items,
                  this.filteredAssets,
                  Grid.assets
                );
              }
              this.lazyLoadingLines = false;
              this.lazyLoadingLinesUnits = '';
            }, (carrier: ConfigurationGroupsMultiselectAssetLinesCarrierList) => {
              console.log("ERROR: Asset Lines");
              this.lazyLoadingLines = false;
              this.lazyLoadingLinesUnits = '';
            });
            
            //...
```

We also need a method, which we will call from the FE, to test if the individual asset row is still being loaded for lines.
We will test for this in the HTML in order to know if we should show the loading indicator

```ts
unitIsLazyLoading(unit: string, units: string): boolean {
	var listUnits = units.split(',');
	return listUnits.includes(unit);
}
```

OK, now, where you setup your Grid, you need to indicate which column is a lazy loading column.
For our eg. we are looking into the Asset Grid...

```ts
private setupConfigAssetsGrid() {
	//...
	this.assetsColumns = Array(this.assetsHiddenColumnSettings.length);
    for (let i = 0, len = this.assetsHiddenColumnSettings.length; i < len; i++) {
	    //...
		this.assetsColumns[columnSetting.index - 1] = {
	        field: column.field, 
	        //...
	        lazy: this.configAssetColumnLazy[column.field],
	      };
```

## FR UI HTML file

Next we will add the lazy logic into the HTML.
Basically we will add in some checks in the HTML to determine if the lazy loading should be shown.
We will add this into the column templates as needed (Please remember for special column behaviour we will add special templates).
Once again we will focus on the lines example, but leave in another lazy loading, just to show you could have more than one on the same column

```html
<!-- ASSETS PANEL GRID -->
<div class="row flex-grow-1 position-relative">
<kendo-grid #assetsGrid [data]="filteredAssets"                       >
	<!-- Columns -->
	<kendo-grid-column *ngFor="let col of assetsColumns;"             >
	
		<!--cell: multi lines-->
		<ng-template                              >
			<!-- ... -->
			<div>
				<div *ngIf="                      >
				(col?.lazy === 'alerts' && lazyLoadingAlerts && unitIsLazyLoading(dataItem.configurationGroupId, lazyLoadingAlertsUnits)) ||
				(col?.lazy === 'lines' && lazyLoadingLines && unitIsLazyLoading(dataItem.configurationGroupId, lazyLoadingLinesUnits))">
					<kendo-skeleton
					  shape="text"
					  animation="pulse"
					  width="100%"
					</kendo-skeleton>
				</div>
				<!-- ... -->
			</div>
```

Now you can apply this to something you would need to lazy load.