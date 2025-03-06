---
created: 2023-04-03T16:58
updated: 2024-05-24T13:53
---
```powershell

# All services on network server
Get-Service -ComputerName dsintapp08

# Eg look for "daylight" service on a server
Get-Service -ComputerName dsintapp02 | Where-Object {$_.Name -like '*Daylight*'}

# Force start service on remote server
$credential = Get-Credential
Invoke-Command -ComputerName dsintapp02 -Credential $credential -ScriptBlock {Start-Service Spooler -Force}

```


## Check for Services

```powershell
Enable-PSRemoting -Force

$remoteServer = "HSDUBIIS09"
$servicePattern = "Daylight*"

# Get the services that match the pattern on the remote server
$services = Get-Service -ComputerName $remoteServer | Where-Object { $_.Name -like $servicePattern }

# Check if any matching services are found and if they are running
if ($services.Count -gt 0) {
    foreach ($service in $services) {
        if ($service.Status -eq "Running") {
            Write-Output "Service '$($service.Name)' is running on $remoteServer."
        } else {
            Write-Output "Service '$($service.Name)' is not running on $remoteServer."
        }
    }
} else {
    Write-Output "No services matching the pattern '$servicePattern' were found on $remoteServer."
}

```
