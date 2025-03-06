[[Docker]]ize **DeviceState**
Out of Deviceconfig API

- Seperate
- Deploy as  docker on aws
- TECHDEBT-63
- Wrap many times
	- 
- Routing
	- Moved Route to **Core**
- Filter
	- HandleResponse
	- Sync call
	- Action [[filter]] [ [[Route]] ("[controller]")]
		- Global, Controller, Action: Level
		- Apply something as action - will applies to all
		- IOrderFilter
	- Result Filter
	- Exception Filter - no - keeping with what we have

- .Net6
-  - minimal API - all in one file
- Global using...

- Better structure: Fast endpoints
- https://dev.to/djnitehawk/building-rest-apis-in-net-6-the-easy-way-3h0d
- Youtube: NiX Chapsis
	- https://www.youtube.com/watch?v=z32_7KgCr6c
	- Kata? Upgraded from nancy?
	- https://www.youtube.com/watch?v=z32_7KgCr6c
	- https://github.com/CarterCommunity/Carter
	- Conrainerization: https://docs.microsoft.com/en-us/virtualization/windowscontainers/quick-start/building-sample-app
- More of his notes
	- Need to install VS2022 for .NET6 workloads : [https://dotnet.microsoft.com/en-us/download/dotnet/6.0](https://dotnet.microsoft.com/en-us/download/dotnet/6.0 "https://dotnet.microsoft.com/en-us/download/dotnet/6.0")
	
	Some materials I am referring besides the documentation:
	
	[.NET 6 Startup Changes - Handling Program.cs Without Startup.cs - YouTube](https://www.youtube.com/watch?v=vdhFw1VSowg "https://www.youtube.com/watch?v=vdhfw1vsowg") (Startup.cs and Global.asax replaced by Program.cs)  
	
	[WebAPI Improvements in .NET 5 - OpenAPI, Better F5, and NSwag - YouTube](https://www.youtube.com/watch?v=nY-w9wPFEuY "https://www.youtube.com/watch?v=ny-w9wpfeuy") (.NET6 benefits from all these + minimal APIs and C# 10)  
	
	[CRUD with a .NET 6 Web API & Entity Framework Core 🚀 Full Course - YouTube](https://www.youtube.com/watch?v=Fbf_ua2t6v4 "https://www.youtube.com/watch?v=fbf_ua2t6v4") (Quick startup course to get you up and going)  
	
	[Upgrading from .NET Framework to .NET 6 - YouTube](https://www.youtube.com/watch?v=cOHXt_0VDRI "https://www.youtube.com/watch?v=cohxt_0vdri") (Official .NET vid based on MS documentation)  
	
	[](https://www.youtube.com/watch?v=Fbf_ua2t6v4 "https://www.youtube.com/watch?v=fbf_ua2t6v4")  
	
	Full .NET6 MVC app tutorial: (Excuse the mic quality and length; the course is really good and extensive):
	
	[Learn ASP.NET Core MVC (.NET 6) - Full Course - YouTube](https://www.youtube.com/watch?v=hZ1DASYd9rk "https://www.youtube.com/watch?v=hz1dasyd9rk")


Questions
- Was there some stable tutorial you followed?
- 