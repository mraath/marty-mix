
## Short Config eg

```c#
//Commands eg

List<Task<long>> tasks = new List<Task<long>>();

foreach (var asset in assetsDSTCommands)
{
	tasks.Add(_mobileUnitCommandsManager.SendCommandToMobileUnit(authToken, asset.GroupId, asset.MobileUnitId, (int)CommandIdType.UpdateAssetTimezoneDeviation, null, asset.Param1, asset.Param2, asset.Param3));
}

//If you want to await - doesn't have to if you dont need anything from the above... or like in a swagger call
await Task.WhenAll(tasks); //for the API I did nothing of this...


//Inside one of my procedures, I has a LONG running stored proc... to make it work... I wrapped the call to this method as a tasks.add(MethodContainingLongRunningStoredProc)
//Inside , I called it like this now async Task<xxxx> MethodContainingLongRunningStoredProc
var organisationAssetTimeZones = await _deviceConfigRepo.OrganisationGetAssetDataTimeZones().ConfigureAwait(false);
```


## Longer eg

```c#
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

class Program
{
    static async Task Main(string[] args)
    {
        Console.WriteLine("Main app started.");

        // Kick off the sections asynchronously
        Task organizationTask = ProcessOrganizationsAsync();
        Task commandTask = ProcessCommandsAsync();

        // Continue immediately
        Console.WriteLine("Done.");

        // Wait for the organization and command tasks to complete
        await Task.WhenAll(organizationTask, commandTask);

        Console.WriteLine("Organizations and commands processing is complete.");
    }

    static async Task ProcessOrganizationsAsync()
    {
        Console.WriteLine("Processing organizations...");

        // Simulate some work that takes 10 seconds
        await Task.Delay(10000);

        // Call another async method
        await GetFromDBAsync();

        Console.WriteLine("Organizations processing is complete.");
    }

    static async Task GetFromDBAsync()
    {
        Console.WriteLine("Getting data from the database...");

        // Simulate some work that takes 10 seconds
        await Task.Delay(10000);

        Console.WriteLine("Data retrieval from the database is complete.");
    }

    static async Task ProcessCommandsAsync()
    {
        Console.WriteLine("Processing commands...");

        // Simulate some work that takes 5 seconds
        await Task.Delay(5000);

        Console.WriteLine("Commands processing is complete.");
    }
}
```

## Not losing the relationship

```c#
public class MobileUnitMessage
{
    public int MobileUnitId { get; set; }
    public int MessageId { get; set; }
}

// ...

var tasks = new List<Task<MobileUnitMessage>>();
foreach (var mobileUnitId in mobileUnitIds)
{
    var task = YourAsyncMethod(mobileUnitId);
    tasks.Add(task.ContinueWith(t => new MobileUnitMessage
    {
        MobileUnitId = mobileUnitId,
        MessageId = t.Result
    }));
}

await Task.WhenAll(tasks);

var mobileUnitMessages = tasks.Select(t => t.Result).ToList();

// Now you have a list of MobileUnitMessage instances, each containing MobileUnitId and MessageId

```