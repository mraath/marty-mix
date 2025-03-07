---
created: 2025-03-05T12:29
updated: 2025-03-07T08:00
---
## Methods

- C:\Projects\Fleet.Services.SelectionCriteria\Fleet.Services.SelectionCriteria.Web.Api\Controllers\SelectionCriteriaController.cs
	- SelectionCriteriaController.UpdateAsync
		- selectionCriteriaManager.Update
			- repository.SaveString
				- C:\Projects\Fleet.Services.SelectionCriteria\Fleet.Services.SelectionCriteria.Data.Postgres\SelectionCriteriaPostgresRepository.cs
					- SelectionCriteriaPostgresRepository.SaveString
						- Save > connectionManager.GetWriterConnection > NpgsqlCommand > cmd.ExecuteNonQueryAsync
- Settings:
	- SelectionCriteriaWriterConnectionString
	- "SelectionCriteriaWriterConnectionString": "Host=mix-int-aurpg01.cluster-chal8xqayxey.eu-west-1.rds.amazonaws.com;Username=selectioncriteriauser;Password=2HFt4j37a3yZ;Database=selectioncriteria;"

- Tim's way: [[Overriding the Column Width]]
- Looking for the DB: [[Selection Criteria DB]]

