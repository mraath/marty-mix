---
created: 2025-04-22T09:14
updated: 2025-04-22T09:26
---
> Sometimes we have ==issues== with languaging. Usually if we have something dynamic in the language string. Eg. "You have selected 5 asset(s) to be moved..." it might cause issues. Herewith how you can resolve this.


## Languaging Pot file

Do the normal languaging as per [[Frangular Languaging]]

## HTML

```html
<div class="well">
  <p innerHtml="{{resetModalTranslatedText}}"></p>
</div>
```

Introduce a new variable which will be used to translate the text in the .ts file.

## TS file

1) Set it with all the other text strings.

```c#
resetModalTranslatedText: string = "";
```

2) Do the initial translation of the original text into this translated text

```c#
private translateMessages() {
	//... other code
	this.resetModalTranslatedText = this.languageService.translate(this.resetModalText)
	//... other code
```

3) Set this in an event

In some kind of event, eg. when the user selected an asset:
- set the translated text (resetModalTranslatedText) to the translated originally set code
- replace the count within this text
- optional, console write it out to test

```c#
onAssetSelectionChange(selection: any) {
	//... other code
	this.resetModalTranslatedText = this.languageService.translate(this.resetModalText);
	this.resetModalTranslatedText = this.resetModalTranslatedText.replace("{{assetSelected}}", this.assetSelected.toString());
    console.log(this.resetModalTranslatedText);
    //.. other code
```

## Test

- Test locally
- Test on INT
