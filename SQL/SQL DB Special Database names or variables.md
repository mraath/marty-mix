---
created: 2022-07-15T16:27
updated: 2023-10-26T09:45
---
These are found in the Database Repo

| DB                  | Special Variable         | Eg                                                         |
| ------------------- | ------------------------ | ---------------------------------------------------------- |
| FMOnlineDB          | [$(Controller)]          | [$(Controller)].[dbo].[GenerateBigId]                      |
| AssetDB             | [$(DatabaseName)]        | [$(DatabaseName)].[dbo].[ExtendedData]                     |
| DeviceConfiguration | [$(DeviceConfiguration)] | [$(DeviceConfiguration)].[library].[Devices]               |
|                     | [$(DWLinkedServer)]      | [$(DWLinkedServer)].[$(MiXData)].[dbo].[DIM_Organisations] |
|                     |                          | [$(DynaMiX)].[DynaMiX].[GroupTypes]                        |
|                     |                          | [$(CommsDB)].dbo.hosts                                     |
| There are more      |                          |                                                            |

[[DB]] [[DBNames]]

## Code Refs

```txt
C:\Projects\DynaMiX.Backend\MiX.UnitConfiguration\MiX.UnitConfiguration.GenerateUI\Model\SqlEnvironmentSettings.cs

```
