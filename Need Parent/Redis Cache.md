# Redis Cache

The general pattern for implementing caching with invalidation is to use a ==cache key== that incorporates a **version number** or **timestamp** that changes whenever the data being cached is _updated_. 
When the cached data is _read_, the current version number or timestamp is _compared_ to the version number or timestamp stored in the cache, and if they differ, the cache is considered invalid and is discarded.

Here's an example of how this can be implemented in C# using Redis:
Store the data being cached along with a version number or timestamp in Redis using a key based on the cache key and the version number or timestamp.
When reading the cached data, first check the version number or timestamp stored in Redis. If it differs from the current version number or timestamp, discard the cache and retrieve the latest data.
When updating the data, update the version number or timestamp stored in Redis and invalidate the existing cache by discarding it.

Here's an example code:

``` c#
using StackExchange.Redis;

public class RedisCache
{
    private readonly ConnectionMultiplexer _redis;
    private readonly string _cacheKey;

    public RedisCache(ConnectionMultiplexer redis, string cacheKey)
    {
        _redis = redis;
        _cacheKey = cacheKey;
    }

    public T Get<T>(string key, Func<T> fetchData)
    {
        var cacheKey = $"{_cacheKey}:{key}";
        var database = _redis.GetDatabase();
        var cacheData = database.StringGet(cacheKey);
        if (!cacheData.HasValue)
        {
            var data = fetchData();
            database.StringSet(cacheKey, JsonConvert.SerializeObject(data));
            return data;
        }

        return JsonConvert.DeserializeObject<T>(cacheData);
    }

    public void Invalidate(string key)
    {
        var cacheKey = $"{_cacheKey}:{key}";
        var database = _redis.GetDatabase();
        database.KeyDelete(cacheKey);
    }
}
```


In this example, the Get method takes a key and a delegate that is used to fetch the data from the underlying data source if the cache is invalid. 
The Invalidate method discards the cache for a given key. 
The cache key used in Redis is constructed by concatenating the _cacheKey property with the provided key.

To further safeguard this you could make use of the [[Command Pattern]]

## Justus added in this for caching lately 

- /MiX.DeviceConfig.Api.Client/Interfaces/IMobileUnitRepository.cs
- /MiX.DeviceConfig.Api.Client/Repositories/MobileUnitRepository.cs
- /MiX.DeviceConfig.Api.Client.Tests/MobileUnitTests.cs
- /DynaMiX.DeviceConfig.DataAccess/Repository/TemplateLevel/MobileDeviceTemplates.cs
- /DynaMiX.DeviceConfig.Logic/Managers/TemplateLevel/MobileDeviceTemplateManager.cs
- /DynaMiX.DeviceConfig.Services.API/Controllers/TemplateLevel/MobileDeviceTemplateController.cs
- /DynaMiX.DeviceConfig.Services.API/Routes/TemplateLevel/MobileDeviceTemplateControllerRoutes.cs