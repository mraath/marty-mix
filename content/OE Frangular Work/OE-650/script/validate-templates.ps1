$rootPath = "c:\Projects\MiX.Fleet.UI"
$results = @{
    MissingTemplates = @()
    DynamicLoading = @()
    TemplateCache = @()
    PropertyTemplates = @()
}

# 1. Template Path Validation
$templatePaths = @(
    "_cdn/Templates/ConfigAdmin/CalibrationBooleanTemplate.html",
    "_cdn/Templates/ConfigAdmin/CalibrationCounterTemplate.html",
    "_cdn/Templates/ConfigAdmin/CalibrationLinearTemplate.html",
    "_cdn/Templates/ConfigAdmin/CalibrationLookupTemplate.html",
    "_cdn/Templates/ConfigAdmin/CalibrationFormulaTemplate.html",
    "UI/Js/ConfigAdmin/Templates/LocationTemplateTemplate.html",
    "UI/Js/ConfigAdmin/Templates/LocationsLibraryTemplate.html"
    # Add other paths from the plan
)

foreach ($path in $templatePaths) {
    $fullPath = Join-Path $rootPath $path
    if (-not (Test-Path $fullPath)) {
        $results.MissingTemplates += $path
    }
}

# 2. Scan for Dynamic Loading
$controllers = Get-ChildItem -Path (Join-Path $rootPath "UI/Js/ConfigAdmin") -Filter "*Controller.js" -Recurse
foreach ($controller in $controllers) {
    $content = Get-Content $controller.FullName
    $matches = $content | Select-String -Pattern "getTemplate|templateUrl|\$templateCache" -AllMatches
    foreach ($match in $matches) {
        $results.DynamicLoading += @{
            File = $controller.Name
            Line = $match.LineNumber
            Match = $match.Line.Trim()
        }
    }
}

# 3. Find Property Templates
$propertyTemplates = Get-ChildItem -Path (Join-Path $rootPath "_cdn/Templates/ConfigAdmin/Properties") -Filter "*.html" -Recurse
foreach ($template in $propertyTemplates) {
    $results.PropertyTemplates += $template.FullName.Replace($rootPath, "").TrimStart("\")
}

# Output Results
$resultsFile = Join-Path $rootPath "template-validation-results.json"
$results | ConvertTo-Json -Depth 4 | Out-File $resultsFile

Write-Host "Template Validation Results:"
Write-Host "=========================="
Write-Host "Missing Templates: $($results.MissingTemplates.Count)"
Write-Host "Dynamic Loading Points: $($results.DynamicLoading.Count)"
Write-Host "Property Templates Found: $($results.PropertyTemplates.Count)"
Write-Host ""
Write-Host "Full results written to: $resultsFile"