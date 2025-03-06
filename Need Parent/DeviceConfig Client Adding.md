Date: 2022-06-20 Time: 11:03
Status:  
Friend: 

# DeviceConfig Client Adding

## Image


## Description

## Code sections

### Interface
```c#
using MiX.DIConfig.DCAN.Dtos;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace MiX.DeviceConfig.Api.Client.Interfaces
{
    public interface IDynamicCANRepository
    {
        Task<List<AvailableScriptsInfoEntry>> GetSciptsByVinNumbers(string authToken, List<string> VINNumbers, long? correlationId = null);
    }
}
```

### Repository
```c#
using MiX.Core.Clients;
using MiX.Core.Retries;
using MiX.Core.Serialization;
using MiX.DeviceConfig.Api.Client.Interfaces;
using MiX.DIConfig.DCAN.Dtos;
using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Threading.Tasks;

namespace MiX.DeviceConfig.Api.Client.Repositories
{
    public class DynamicCANRepository : RestRepositoryBase, IDynamicCANRepository
    {
        readonly HttpRetries _httpNoRetries; // used for calls that should not ever be made more than once
        
        internal DynamicCANRepository(string resourceDataApiUrl, ISerializer serializer, Func<RetryStrategy> retryFactory, TimeSpan timeout)
                : base("api", resourceDataApiUrl, serializer, retryFactory, timeout)
        {
            RetryStrategy retryFactoryForNoRetries() => new NoRetryStrategy();
            _httpNoRetries = new HttpRetries(CreateHttpClient(TimeSpan.FromSeconds(120)), serializer, retryFactoryForNoRetries);
        }

        public async Task<List<AvailableScriptsInfoEntry>> GetSciptsByVinNumbers(string authToken, List<string> VINNumbers, long? correlationId = null)
        {
            HttpRequestMessage requestFunc()
            {
                var request = NewPostRequest($"{PostPutApiUrl}/dynamic-can/scripts/scipts-by-vin-numbers?authToken={authToken}", VINNumbers, correlationId);
                request.Headers.AcceptEncoding.TryParseAdd("gzip");
                return request;
            }

            return await HttpRetries.Get<List<AvailableScriptsInfoEntry>>(requestFunc).ConfigureAwait(false);
        }
    }
}
```

### Client Register
```c#
using MiX.Core.Retries;
using MiX.Core.Serialization;
using MiX.Core.Serialization.Jil;
using MiX.DeviceConfig.Api.Client.Interfaces;
using MiX.DeviceConfig.Api.Client.Repositories;
using System;
using System.Runtime.CompilerServices;

[assembly: InternalsVisibleTo("MiX.DeviceConfig.Api.Client.Tests")]
namespace MiX.DeviceConfig.Api.Client
{
	public static class DeviceConfigClient
	{
		static IDynamicCANRepository _dynamicCANRepository;
		
		public static IDynamicCANRepository DynamicCANRepository
		{
			get
			{
				if (_dynamicCANRepository == null)
					throw new Exception("No DynamicCAN repository registered.");
				return _dynamicCANRepository;
			}
		}
		
		public static void RegisterDynamicCAN(string resourceDataApiUrl, Func<RetryStrategy> retryFactory = null, TimeSpan timeout = default(TimeSpan))
		{
			if (string.IsNullOrEmpty(resourceDataApiUrl))
				throw new ArgumentNullException(nameof(resourceDataApiUrl));

			resourceDataApiUrl = resourceDataApiUrl.TrimEnd(new[] { '/' });

			if (retryFactory == null)
				retryFactory = () => new ElasticRetryStrategy(true, 2, TimeSpan.FromMilliseconds(1000), TimeSpan.FromMilliseconds(10000), true);

			_serializer = new JilSerializer();
			_dynamicCANRepository = new DynamicCANRepository(resourceDataApiUrl, _serializer, retryFactory, timeout);
		}
	}
}	
```

### Test
```c#
using Microsoft.VisualStudio.TestTools.UnitTesting;
using MiX.Core.Retries;
using System;
using System.Collections.Generic;

namespace MiX.DeviceConfig.Api.Client.Tests
{
    [TestClass]
    public class DynamicCANTests
    {
		public static string username = "config@mixtel.com";
		public static string password = "c0nf1gsvc!";
		public static string authtoken = "";
		public static long? correlationId = 123456789147852369;

		[ClassInitialize]
		public static void Initialize(TestContext context)
		{
			//Setting up the testing environment. Eg, localhost, DEV, INT, etc
			var apiurl = "http://localhost/DynaMiX.DeviceConfig.Services.API"; //LOCAL
			//var apiurl = "http://api.deviceconfig.configdev.mix.local/"; //DEV
			//var apiurl = "http://api.deviceconfig.int.development.domain.local"; //INT

			DeviceConfigClient.RegisterAuthenticationRepository_Internal(apiurl, () => new ElasticRetryStrategy(true, 2, TimeSpan.FromMilliseconds(1000), TimeSpan.FromMilliseconds(10000), true));

			DeviceConfigClient.RegisterDynamicCAN(apiurl, () => new ElasticRetryStrategy(true, 2, TimeSpan.FromMilliseconds(1000), TimeSpan.FromMilliseconds(10000), true));

			//Initialise the authtoken
			var auth = DeviceConfigClient.Authentication_Internal.GetAuthToken(username, password, correlationId).ConfigureAwait(false).GetAwaiter().GetResult();
			authtoken = auth.AuthToken;
		}

		[TestMethod]
		public void GetSciptsByVinNumbers()
        {
			List<string> vinNumbers = new List<string> { "1FD0W4GT_JE", "WDB9066592S202912", "WDD21205_6L", "NOVIN2159MB202912" };
			
			var result = DeviceConfigClient.DynamicCANRepository.GetSciptsByVinNumbers(authtoken, vinNumbers, correlationId).ConfigureAwait(false).GetAwaiter().GetResult();

			Assert.IsNotNull(result);
		}
	}
}
```


## Files

## Resources

## Notes

