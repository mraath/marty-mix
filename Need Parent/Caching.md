Date: 2022-06-21 Time: 14:59
Status:
Friend: 

# Caching

## Image

## Description
descr = 1d
sys = 1hr

- Params Descr
use DeviceConfiguration  
select * from library.Parameters where ParameterKey in (  
select ParameterKey from definition.Parameters where SystemName in ( 'CAN.ME.MENTI', '', ''))  
and LibraryKey in (select LibraryKey from library.Libraries where GroupId = xxx)

- Caching
Wynand
	HighVolumeStateCache
		REDIS so onbetroubaar
	**VolatileMemoryCacheV2**
		Internal...
	3rd one with fallbacks
		DI.DP.Core solution
			MobileUnitMapping (3 methods as eg.s)

## Code sections

## Files

## Resources

## Notes

