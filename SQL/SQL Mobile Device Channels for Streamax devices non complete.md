---
created: 2023-10-30T16:55
updated: 2024-10-02T13:40
---
Helpful [[sql]] to get all non-complete Device Channel issues

```sql
-- STM Issues, last Template update code didnt run
select * 

    from (select distinct tdc.LibraryKey, MobileDeviceTemplateKey, DeviceKey 
        from template.DeviceChannels tdc
        inner join library.DeviceChannels ldc on tdc.DeviceChannelKey = ldc.LibraryDeviceChannelKey) a 

    inner join 
        (select distinct LibraryKey, MobileDeviceTemplateKey, DeviceKey 
        from template.Devices  
        where DeviceKey in 
            (select DeviceKey 
                from definition.devices 
                where DeviceId in (311792233444052589, -7099857649368562188, -565349616809011552))
        and IsEnabled = 1) b 
        
    on a.MobileDeviceTemplateKey = b.MobileDeviceTemplateKey and a.DeviceKey != b.DeviceKey and a.LibraryKey = b.LibraryKey

-- STM devices
-- SELECT * from definition.devices where DeviceId in (311792233444052589, -7099857649368562188, -565349616809011552)
```

