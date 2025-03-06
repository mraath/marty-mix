#done #spike #die
Friend: [[DIE-485 DI Config Asset config file]]

# DIE-488 Asset config file (DS and Non-DS) - Spike (0.5days)

[[DIE-488] DI Config: Asset config file (DS and Non-DS) - Spike (0.5days) - MiX Telematics JIRA](https://jira.mixtelematics.com/browse/DIE-488)

  FOR: Oman (18.17), other AWS env

  Config group page
    List                V Asset configuration file (report icon)
                          CSV file (Asset_configuration_file_assetID_date and time.csv)
                          [DB config]
                            Asset ID (rpt) (sql)
                            Asset description (rpt) (sql)
                            Site (rpt) (sql)
                            Configuration Group (rpt) (sql)
                            Mobile Device Template (rpt) (sql)
                            Event Template (rpt) (sql, just add to final select)
                            Location Template (sql)
                            Configuration status
                            Configuration status time

                            on-board geofences
                            configurations
                            mobile Device settings
                            Event settings
                            Event configurations
                            Location configurations
                            recording options


          lines (rpt)
          Recording options: Events (?) (rpt)

    HAVE:  
      - Insight Reports > List reports > Asset configuration report
      - Nicola C also started work to create a Location configuration report (https://jira.mixtelematics.com/browse/INS-6063 ) which could also have the required SPs


    Fidings:
      - Location: All fields in [Vehicle Location Configuration Report.xls] is found in [Vehicle Location Configuration Report.rdl]
        (found in GetConfigLocationTemplates.sql)
      - Events: xxxxxxx
      - Device: xxxxxxx
      - General: 

---
## Findings

When looking at the report example, I can see different sections.

### [[DIE-490 Config File General Asset Section]]
The first section is mostly handled already by the report Nicola did (INS-6063).
- We should just ensure this sql works accordingly
- We could add the two outstanding fields needed
 
![[Pasted image 20220302102810.png]]

---
### Mobile Device Section
The second part shows all the mobile device settings
As far as I could see we don't do it somewhere else in the system, where we get all this information together for a report.
- We could make use of the BE calls which currently gets all the information for the Edit Mobile Device Settings and just reuse those fields
- We will just have to do some work to get this going

![[Pasted image 20220302103144.png]]

---
### Connected Lines
The next part shows all the lines on the device and what it is connected to.
- There is a stored procedure we can use to get this information
- As indicated on the image below there is some information they need, which the above stored proc currently doesn't have and it seems very specific to each connected device, as far as I could tell it looks at different fields for different connected devices

![[Pasted image 20220302103553.png]]

---
### Recording Options
The next part has all the recording options for each event within the events template
- We will have to write a stored proc to get all these individual event's recording values
- The summary column is something I don't know where to get the data from, this will also need to be added to the above mentioned stored proc

![[Pasted image 20220302103936.png]]

---
### Location Section
The last part shows all the locations within the location template.
- We can make use of Nicola's report at it does all of this (INS-6063)
- We just need to ensure the report still works as expected

![[Pasted image 20220302104116.png]]

---
### Summary
- Check if Nicola's report still works (INS-6063)
- Add the two fields needed
- Reuse the BE logic to get the Mobile Device Settings
- Reuse the Stored Proc to get the connected lines
- Find out about the unknown summary field and add it to the above results
- Create a stored proc to get all the events' recording values
- Find out about the summary column's values and add those to the above
- Use Nicola's report for the location information (INS-6063)

We will also need to:
- Add logic to get all the above in one place
- Transform the values into an Excel report
- Potentially we could split the sections into tabs

I have sent Nicole a video to ask some of the above questions, however, I think we are fine for now. I will add any feedback I receive from her in here.