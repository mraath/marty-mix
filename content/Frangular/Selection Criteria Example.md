---
wiki_ingested: 2026-05-28
created: 2025-10-20T08:51
updated: 2025-10-30T08:38
---

## Selection Criteria

In order to save information to the selection criteria you will need to do the following.
I simplified this to only saving and then retrieving a string from the Selection Criteria.
I will call it **myVal**.

## Key

You will need to add a new key to be used to write data to and read data from Selection Criteria.

eg. selection-criteria-keys.ts
```ts
static myValSetting = "myVal";
```

## Selection Criteria Logic

eg. grid-selection-criteria.service.ts

### Import

**Add**: SelectionCriteriaStringItemToSaveCarrier as per the below:

import { Dictionary, ISelectionCriteriaService, ISessionService, SelectionCriteriaDictionaryItemToSaveCarrier, SelectionCriteriaItemCarrier, SelectionCriteriaListItemToSaveCarrier, SelectionCriteriaQueryCarrier, SelectionCriteriaResult, SelectionCriteriaUpdate, tokenSelectionCriteriaService, tokenSessionService, **SelectionCriteriaStringItemToSaveCarrier** } from "@mixtel/dynamixframework";

### Saving
```ts
//Saving the value
updateMyVal(selectionCriteriaKey: string, myVal: string): Observable<boolean> {
    //Setup single string value to save
    let myNewVal: SelectionCriteriaStringItemToSaveCarrier = new SelectionCriteriaStringItemToSaveCarrier();
    myNewVal.key = selectionCriteriaKey;
    myNewVal.value = myVal;

    //Update query for saving to the selection criteria
    let query: SelectionCriteriaUpdate = new SelectionCriteriaUpdate();
    query.userId = this.sessionService.accountId;
    query.globalKey = false;
    query.strings = [];
    query.strings.push(myNewVal);

    //Save the selection criteria
    return this.selectionCriteriaService.save(query)
      .pipe(takeWhile(() => this.alive), mergeMap((data: SelectionCriteriaQueryCarrier) => {
        return of(true);
      }));
}
```

### Reading
```ts
//Getting the value
getMyVal(selectionCriteriaKey: string): Observable<string> {
    //Setup value to get (key)
    let myQuery: SelectionCriteriaItemCarrier = new SelectionCriteriaItemCarrier();
    myQuery.key = selectionCriteriaKey;

    //Setup query for the Selection Criteria (single string for this example)
    let query: SelectionCriteriaQueryCarrier = new SelectionCriteriaQueryCarrier();
    query.userId = this.sessionService.accountId;
    query.globalKey = false;
    query.strings = [];
    query.strings.push(myQuery);

    //Get the value from the selection criteria
    return this.selectionCriteriaService
        .query(query)
        .pipe(takeWhile(() => this.alive), mergeMap((data: SelectionCriteriaResult) => {
          if (data) {
            if (data.strings) {
              let myVal = data.strings.firstOrDefault(x => x.key === selectionCriteriaKey);
              if (myVal != null && myVal.value) {
                return of(myVal.value);
              }
            }
          }
          return of(""); //No value found - could improve on this poc
        }));
  }
```

## Calling from your UI code

### Saving the value
(eg. from an event like changeEvent)

```ts
//Write new myVal in eg. a change event
var newVal= Date.now() + "";

this.gridSelectionCriteriaService.updateMyVal(SelectionCriteriaKeys.myValSetting, newVal)
.pipe(takeWhile(() => this.alive))
	  .subscribe(() => {});
```

### Reading the value
(eg. when you need to display it or use it for logic)

```ts
this.gridSelectionCriteriaService.getMyVal(SelectionCriteriaKeys.myValSetting)
  .pipe(takeWhile(() => this.alive))
  .subscribe((data: string) => {
	this.myVal = data; //Setting this local var to the data read
  });
```

## Testing in Development tools

Below we can see that both the update and the querying of the new value is working. 
For the **update** we can see when you pass in the key and the value It was actually successful, indicated by the status 200. 
When we **query** the correct key, we can see that the selection criteria returns the correct value.


![[Selection Criteria Example Testing Dev Tools.png]]

## Examples

Pallavi: https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.UI/pullrequest/133258?_a=files
