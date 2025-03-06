## Old Code

```c#
<div class="control-group">
	<label><span dmx:translate>Peripheral description</span>&nbsp;<span class="field-mandatory" style="">*</span></label>
	<input class="span12"
	 type="text"
	 dmx:validate="deviceName"
	 fleet:peripheral-description-unique-async-params="{ orgId: orgId, id: id }"
	 ng:model="form.deviceName">
</div>
```

## The idea I had

```c#
div class="control-group">
	<label><span dmx:translate>Peripheral description</span>&nbsp;<span class="field-mandatory" style="">*</span></label>
	
	<input class="span12"
	 ng-show="form.deviceTypeId !== 128"
	 type="text"
	 dmx:validate="deviceName"
	 fleet:peripheral-description-unique-async-params="{ orgId: orgId, id: id }"
	 ng:model="form.deviceName">
	 
	<input class="span12"
	 ng-show="form.deviceTypeId == 128"
	 type="text"
	 ng:model="form.deviceName">
</div>
```
