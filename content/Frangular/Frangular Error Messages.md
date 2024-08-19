---
created: 2024-08-14T15:57
updated: 2024-08-15T13:47
---
> [!Info] Please note
> If you have a spinner going and want it to be stopped when closing the error message, the error message does this for you.
> You just need to ensure you are making use of the spinnerService, at least setting it to true, before the code runs which could cause an error
> [[Frangular Spinner]]

## CHAT WITH Timothy

The error handling is on the UI. Check the example

## Error Component Repos

I have already pulle this into the config groups repo:

- Component - [error.component.ts - Repos (visualstudio.com)](https://mixtelematics.visualstudio.com/Fleet/_git/Fleet.Services.Operations.UI?path=/src/app/shared/components/models/error/error.component.ts "https://mixtelematics.visualstudio.com/fleet/_git/fleet.services.operations.ui?path=/src/app/shared/components/models/error/error.component.ts")
- HTML - [error.component.html - Repos (visualstudio.com)](https://mixtelematics.visualstudio.com/Fleet/_git/Fleet.Services.Operations.UI?path=/src/app/shared/components/models/error/error.component.html "https://mixtelematics.visualstudio.com/fleet/_git/fleet.services.operations.ui?path=/src/app/shared/components/models/error/error.component.html")

## Images

Add it into any module you will need... Fleet kept things apart in the solution, looks like this:

![[Frangular Error Messages components module.png]]

It then gets referenced like this:

![[Frangular Error Messages app component.png]]
