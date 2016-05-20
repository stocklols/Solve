SELECT 
	t.name TableName
	, s.[name] StatisticsName
	, STATS_DATE(t.object_id,s.[stats_id]) LastUpdated 
	, (SELECT COUNT(*) FROM sys.stats t INNER JOIN sys.tables tt ON t.object_id = tt.object_id)
FROM sys.[stats] AS s
	JOIN sys.[tables] AS t
		ON [s].[object_id] = [t].[object_id]
WHERE STATS_DATE(t.object_id,s.[stats_id]) < DATEADD(DD,-3,GETDATE())
ORDER BY STATS_DATE(t.object_id,s.[stats_id]) DESC
