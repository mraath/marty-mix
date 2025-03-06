
## Run sync method as async

Task.Run(() => SyncMethod());

## Description

A lot of async work needs to be done to help our API.
We wait for a LOT of things, which results in deadlocks and slow API.
Herewith the basic workflow
Bottom to top fix of async
Repo (DB / EF) > Manager > Controller > Client

## Repo

### Class instantiation with service name

![[Async Work DeviceConfiguration Add ServiceName.png]]

```c#
public class MobileUnitRepository : RestRepositoryBase, IMobileUnitRepository
{
	readonly HttpRetries _httpNoRetries; // used for calls that should not ever be made more than once
	internal MobileUnitRepository(string currentApplicationName, string resourceDataApiUrl, ISerializer serializer, Func<RetryStrategy> retryFactory, TimeSpan timeout)
			: base("api", resourceDataApiUrl, serializer, retryFactory, timeout)
	{
		SetServiceName(currentApplicationName);
```

### Interface and Class

```c#
// Interface
Task<List<MobileUnitMapping>> GetAssetMobileUnitMappingsByAssetId(List<long> assetIds);

//Implementation
public async Task<List<MobileUnitMapping>> GetAssetMobileUnitMappingsByAssetId(List<long> assetIds)
{
	Stopwatch sw = new Stopwatch();
	sw.Start();

	ISettingsProvider sp = SettingsProviderFactory.GetProvider(CoreConstants.ServiceName);
	string connectionString = sp.GetString(CoreConstants.SettingNames.DeviceConfigDb);

	List<MobileUnitMapping> result;

	using (SqlConnection conn = new SqlConnection(connectionString))
	{
		await conn.OpenAsync().ConfigureAwait(false);

		var queryResult = await conn.QueryAsync<MobileUnitMapping>("[mobileunit].[MobileUnit_GetAssetMobileUnitMappingsByAssetId]",
			new
			{
				assetIds = ListLongsToDataTable(assetIds)
			},
			commandType: CommandType.StoredProcedure).ConfigureAwait(false);

		result = queryResult.ToList();
	}

	sw.Stop();
	Logger.Log($"Executed GetMobileUnitMappingsByAssetIds in {sw.Elapsed.TotalMilliseconds * 0.001} seconds", LogLevel.Debug);

	return result;
}
```

## Manager

```C#
// Interface
Task<List<MobileUnitMapping>> GetAssetMobileUnitMappingsByAssetId(List<long> assetIds);

//Implementation
private readonly IDeviceConfigRepository _deviceConfigRepo;
//...
_deviceConfigRepo = DependencyRegistry.GetInstance<IDeviceConfigRepository>(false);
//...
_deviceConfigRepo.Dispose();

public async Task<List<MobileUnitMapping>> GetAssetMobileUnitMappingsByAssetId(List<long> assetIds)
{
	return await _deviceConfigRepo.GetAssetMobileUnitMappingsByAssetId(assetIds).ConfigureAwait(false);
}
```

## Test Manager

```c#
//TODO: MR: Test EG here

//Return specific types
//Test more than just not null
//Maybe check that the type is the same
//PS: If no await it returns the task :-)

```

## Controller

```c#
/// <summary>
/// Get the mapping details between a list of assetIds and their zero or more MobileUnits.
/// </summary>
/// <param name="assetIds">The DynaMiX assetIds, this could potentially map to more than one physical MobileUnit per asset id</param>
/// <returns></returns>
[Route(MobileUnitMappingsControllerRoutes.GetMobileUnitMappingsByAssetIds, Name = "GetMobileUnitMappingsByAssetIds")]
[ResponseType(typeof(List<MobileUnitMapping>))]
[HttpPost]
public async Task<HttpResponseMessage> GetAssetMobileUnitMappingsByAssetId(List<long> assetIds)
{
	return await HandledResponseAsync(MobileUnitMappingsControllerRoutes.GetMobileUnitMappingsByAssetIds, async () =>
	{
		using (IMobileUnitManager man = DependencyRegistry.GetInstance<IMobileUnitManager>(false))
		{
			return await man.GetAssetMobileUnitMappingsByAssetId(assetIds).ConfigureAwait(false);
		}
	}).ConfigureAwait(false);
}
```
## Client

```c#
//TODO: MR: Client EG here
```

## Test Client

```c#
[TestMethod]
public void GetAssetsWithOutdatedDaylightSavingsCommands_Test()
{
	var dstCommand = new DaylightSavingsCommand();
	dstCommand.GroupIds = "2364975042774694384";
	dstCommand.MobileUnitIds = "5458996954334640037";

	//Return specific types
	List<AssetWithoutDST> result = DeviceConfigClient.MobileUnitCommands.GetAssetsWithOutdatedDaylightSavingsCommands(authtoken, dstCommand, correlationId).ConfigureAwait(false).GetAwaiter().GetResult();

	Assert.IsNotNull(result);
	//TODO: MR: Add actual test
	//Maybe check that the type is the same
	Assert.IsInstanceOfType(result, typeof(List<AssetWithoutDST>));
}

//PS: If no await it returns the task :-)
```

![[Async Work DeviceConfiguration Test Client Call.png]]


## Video
https://mixtelematics-my.sharepoint.com/:v:/p/zonika_smit/EZOCn4BU__FAhbLzCpBkAdoB6IPem4-ikSmxOjDbk2AgxA
