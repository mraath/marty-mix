---
wiki_ingested: 2026-05-28
---
# Template Analysis and Implementation Plan

## 1. Core Shared Templates
```
_cdn/.../Shared/
- LoadingModalTemplate.html
- ValidationMessageTemplate.html
- ErrorMessageTemplate.html
- ConfirmationModalTemplate.html
- BreadcrumbTemplate.html
- SearchBoxTemplate.html
```

## 2. Navigation Components
```
_cdn/.../Navigation/
- PaginationTemplate.html
- FilterBarTemplate.html
- SortingHeaderTemplate.html
- ActionButtonsTemplate.html
```

## 3. Property Templates Implementation
Located in `_cdn/Templates/ConfigAdmin/Properties/`:

### Boolean Parameter Template
```html
<div class="parameter-template boolean-parameter">
    <div class="form-group">
        <label for="{{parameter.id}}">{{parameter.name}}</label>
        <div class="checkbox">
            <input type="checkbox" 
                   id="{{parameter.id}}" 
                   ng-model="parameter.value"
                   ng-change="onParameterChanged()">
            <span class="help-block">{{parameter.description}}</span>
        </div>
    </div>
</div>
```

### Numeric Parameter Template
```html
<div class="parameter-template numeric-parameter">
    <div class="form-group">
        <label for="{{parameter.id}}">{{parameter.name}}</label>
        <input type="number" 
               class="form-control" 
               id="{{parameter.id}}" 
               ng-model="parameter.value"
               ng-change="onParameterChanged()"
               min="{{parameter.min}}"
               max="{{parameter.max}}"
               step="{{parameter.step}}">
        <span class="help-block">{{parameter.description}}</span>
    </div>
</div>
```

### String Parameter Template
```html
<div class="parameter-template string-parameter">
    <div class="form-group">
        <label for="{{parameter.id}}">{{parameter.name}}</label>
        <input type="text" 
               class="form-control" 
               id="{{parameter.id}}" 
               ng-model="parameter.value"
               ng-change="onParameterChanged()"
               ng-maxlength="{{parameter.maxLength}}">
        <span class="help-block">{{parameter.description}}</span>
    </div>
</div>
```

### Enum Parameter Template
```html
<div class="parameter-template enum-parameter">
    <div class="form-group">
        <label for="{{parameter.id}}">{{parameter.name}}</label>
        <select class="form-control" 
                id="{{parameter.id}}" 
                ng-model="parameter.value"
                ng-change="onParameterChanged()"
                ng-options="option.value as option.label for option in parameter.options">
        </select>
        <span class="help-block">{{parameter.description}}</span>
    </div>
</div>
```

### Time Parameter Template
```html
<div class="parameter-template time-parameter">
    <div class="form-group">
        <label for="{{parameter.id}}">{{parameter.name}}</label>
        <div class="input-group">
            <input type="time" 
                   class="form-control" 
                   id="{{parameter.id}}" 
                   ng-model="parameter.value"
                   ng-change="onParameterChanged()">
            <span class="input-group-addon">
                <i class="fa fa-clock-o"></i>
            </span>
        </div>
        <span class="help-block">{{parameter.description}}</span>
    </div>
</div>
```

## 4. Template Organization Structure
```
UI/Js/ConfigAdmin/
├── Base/
│   ├── BaseLibraryTemplate.html
│   ├── BaseEditTemplate.html
│   └── BaseParameterTemplate.html
├── Shared/
│   ├── Navigation/
│   ├── Modals/
│   └── Forms/
└── Templates/
    ├── Library/
    ├── Edit/
    └── Parameters/
```

## 5. PowerShell Validation Script
```powershell
$rootPath = "c:\Projects\MiX.Fleet.UI"
$propertyTemplatesPath = Join-Path $rootPath "_cdn\Templates\ConfigAdmin\Properties"

# Create directory if it doesn't exist
if (-not (Test-Path $propertyTemplatesPath)) {
    New-Item -ItemType Directory -Path $propertyTemplatesPath -Force
    Write-Host "Created directory: $propertyTemplatesPath"
}

# Define and create templates
$propertyTemplates.Keys | ForEach-Object {
    $templatePath = Join-Path $propertyTemplatesPath $_
    if (-not (Test-Path $templatePath)) {
        Write-Host "Creating template: $_"
        $propertyTemplates[$_].Content | Out-File -FilePath $templatePath -Encoding UTF8
    }
}
```

## 6. Next Steps
1. Validate all template paths exist
2. Complete property template mappings
3. Document template dependencies
4. Implement template validation
5. Create template dependency graph
```// filepath: C:\Projects\marty-mix\content\Frangular Template Editing\CoPilotEditTemplates.md
# Template Analysis and Implementation Plan

## 1. Core Shared Templates
```
_cdn/.../Shared/
- LoadingModalTemplate.html
- ValidationMessageTemplate.html
- ErrorMessageTemplate.html
- ConfirmationModalTemplate.html
- BreadcrumbTemplate.html
- SearchBoxTemplate.html
```

## 2. Navigation Components
```
_cdn/.../Navigation/
- PaginationTemplate.html
- FilterBarTemplate.html
- SortingHeaderTemplate.html
- ActionButtonsTemplate.html
```

## 3. Property Templates Implementation
Located in `_cdn/Templates/ConfigAdmin/Properties/`:

### Boolean Parameter Template
```html
<div class="parameter-template boolean-parameter">
    <div class="form-group">
        <label for="{{parameter.id}}">{{parameter.name}}</label>
        <div class="checkbox">
            <input type="checkbox" 
                   id="{{parameter.id}}" 
                   ng-model="parameter.value"
                   ng-change="onParameterChanged()">
            <span class="help-block">{{parameter.description}}</span>
        </div>
    </div>
</div>
```

### Numeric Parameter Template
```html
<div class="parameter-template numeric-parameter">
    <div class="form-group">
        <label for="{{parameter.id}}">{{parameter.name}}</label>
        <input type="number" 
               class="form-control" 
               id="{{parameter.id}}" 
               ng-model="parameter.value"
               ng-change="onParameterChanged()"
               min="{{parameter.min}}"
               max="{{parameter.max}}"
               step="{{parameter.step}}">
        <span class="help-block">{{parameter.description}}</span>
    </div>
</div>
```

### String Parameter Template
```html
<div class="parameter-template string-parameter">
    <div class="form-group">
        <label for="{{parameter.id}}">{{parameter.name}}</label>
        <input type="text" 
               class="form-control" 
               id="{{parameter.id}}" 
               ng-model="parameter.value"
               ng-change="onParameterChanged()"
               ng-maxlength="{{parameter.maxLength}}">
        <span class="help-block">{{parameter.description}}</span>
    </div>
</div>
```

### Enum Parameter Template
```html
<div class="parameter-template enum-parameter">
    <div class="form-group">
        <label for="{{parameter.id}}">{{parameter.name}}</label>
        <select class="form-control" 
                id="{{parameter.id}}" 
                ng-model="parameter.value"
                ng-change="onParameterChanged()"
                ng-options="option.value as option.label for option in parameter.options">
        </select>
        <span class="help-block">{{parameter.description}}</span>
    </div>
</div>
```

### Time Parameter Template
```html
<div class="parameter-template time-parameter">
    <div class="form-group">
        <label for="{{parameter.id}}">{{parameter.name}}</label>
        <div class="input-group">
            <input type="time" 
                   class="form-control" 
                   id="{{parameter.id}}" 
                   ng-model="parameter.value"
                   ng-change="onParameterChanged()">
            <span class="input-group-addon">
                <i class="fa fa-clock-o"></i>
            </span>
        </div>
        <span class="help-block">{{parameter.description}}</span>
    </div>
</div>
```

## 4. Template Organization Structure
```
UI/Js/ConfigAdmin/
├── Base/
│   ├── BaseLibraryTemplate.html
│   ├── BaseEditTemplate.html
│   └── BaseParameterTemplate.html
├── Shared/
│   ├── Navigation/
│   ├── Modals/
│   └── Forms/
└── Templates/
    ├── Library/
    ├── Edit/
    └── Parameters/
```

## 5. PowerShell Validation Script
```powershell
$rootPath = "c:\Projects\MiX.Fleet.UI"
$propertyTemplatesPath = Join-Path $rootPath "_cdn\Templates\ConfigAdmin\Properties"

# Create directory if it doesn't exist
if (-not (Test-Path $propertyTemplatesPath)) {
    New-Item -ItemType Directory -Path $propertyTemplatesPath -Force
    Write-Host "Created directory: $propertyTemplatesPath"
}

# Define and create templates
$propertyTemplates.Keys | ForEach-Object {
    $templatePath = Join-Path $propertyTemplatesPath $_
    if (-not (Test-Path $templatePath)) {
        Write-Host "Creating template: $_"
        $propertyTemplates[$_].Content | Out-File -FilePath $templatePath -Encoding UTF8
    }
}
```

## 6. Next Steps
1. Validate all template paths exist
2. Complete property template mappings
3. Document template dependencies
4. Implement template validation
5. Create template dependency graph