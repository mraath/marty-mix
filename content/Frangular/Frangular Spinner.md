---
created: 2024-08-08T13:46
updated: 2024-08-08T15:37
---

## Your Component

### yourComponent.ts

```ts
import { SpinnerService } from "./shared/components/spinner/spinner.service"; //Or where your service is

export class SomeComponent implements OnInit, OnDestroy {
	private loadSpinner: boolean = true; //Might even leave this out

	constructor(
	    private spinnerService: SpinnerService,

	//Somewhere in a method...
	someMethod(): void {
		//Make it spin
		this.spinnerService.show(true);
		//Do something that takes times, then STOP it from spinning
		this.spinnerService.show(false);
```

## Service

### spinner-service.ts

- It is already written, so you just consume it as per above
- I did make it work the same now as Justus' code, seeing that component has a working spinner 😄

## App Component

### app.component.ts

```ts
import { SpinnerService } from "./shared/components/spinner/spinner.service"; //Or where your service is

export class AppComponent implements OnInit, OnDestroy {
	loadSpinner: boolean = true;

	constructor(
		private spinnerService: SpinnerService,

	ngOnInit() {
		this.spinnerService.onSpinnerChanged$
			.pipe(debounceTime(300), distinctUntilChanged(), takeWhile(() => this.alive))
			.subscribe((status: boolean) => {
				this.loadSpinner = status;
			});
```

### app.component.scss

```scss
.loading-overlay{position:absolute;top:0;left:0;width:100%;height:100%;background-color:rgba(255,255,255,0.498039);z-index:1000;background-image:url(../assets/images/ajax-loader.gif);background-position:50% 50%;background-repeat:no-repeat no-repeat}
```

### app.component.html

```html
<div *ngIf="loadSpinner" class="loading-overlay"></div>
```

## App Module

### app.module.ts

```ts
import { SpinnerService } from "./shared/components/spinner/spinner.service"; //Or where your service is

@NgModule({
	providers: [
		SpinnerService,
		
```

