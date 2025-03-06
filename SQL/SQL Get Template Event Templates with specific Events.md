---
created: 2023-10-26T09:10
updated: 2024-10-02T13:40
---
Great [[sql]] script to find Template Event Templates that contain a specific event(s)

```sql
-- How many Template Event Templates have Events of type 3-Axis Events
-- Get the Keys for 3-Axis
DECLARE @keys TABLE (EventKey INT)
INSERT INTO @keys SELECT EventKey from DeviceConfiguration.[library].[Events] WHERE Description like '%3-Axis%' And LibraryKey = -1 --Default Org

/*
--If you need more information for definition of the Event OR library info for the event
SELECT * from DeviceConfiguration.[definition].[Events] WHERE EventKey IN (SELECT * FROM @keys) --EventKey
SELECT * from DeviceConfiguration.[library].[Events] WHERE EventKey IN (SELECT * FROM @keys) --LibraryEventKey, EventKey, LibraryKey
--The two will be used below, but individually kept here for investigation
SELECT * from DeviceConfiguration.[template].[Events] WHERE EventKey IN (SELECT * FROM @keys) -- Link on TemplateEventKey, EventTemplateKey, LibraryKey, EventKey
SELECT TOP 10 * FROM DeviceConfiguration.[template].EventTemplates --LibraryKey, EventTemplateKey
*/

-- Get the info we need
SELECT ll.Notes, ll.GroupId, tet.Name
    FROM DeviceConfiguration.[template].EventTemplates tet --LibraryKey, EventTemplateKey
    INNER JOIN DeviceConfiguration.[template].[Events] te ON te.EventTemplateKey = tet.EventTemplateKey AND te.LibraryKey = tet.LibraryKey
    INNER JOIN DeviceConfiguration.[library].[Libraries] ll ON ll.LibraryKey = tet.LibraryKey
    WHERE te.EventKey IN (SELECT * FROM @keys)
    ORDER BY ll.Notes
```
