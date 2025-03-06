
```c#
//This works really well
var task = Task.Run(() => _mobileUnitCommandsManager.SendCommandToMobileUnit(...));


// I could get this to work
using System;
using System.Threading.Tasks;

namespace SyncToAsyncConversion
{
    class Program
    {
        static async Task Main(string[] args)
        {
            long result = await LongReturningMethodAsync();
            Console.WriteLine($"Result: {result}");
        }

        static Task<long> LongReturningMethodAsync()
        {
            long value = LongReturningMethod(); // Call the synchronous method
            return Task.FromResult(value); // Wrap the result in a completed task
        }

        static long LongReturningMethod()
        {
            // Replace with your logic to compute the long value synchronously
            return 1234567890;
        }
    }
}

```
