---- Database level:
USE 
GO


---- Overview:
SELECT 
	rt.name AS TableName
	, rc.name AS Column_Name
	, rt.is_replicated
FROM sys.columns rc
	INNER JOIN sys.tables rt ON rc.OBJECT_ID = rt.OBJECT_ID
WHERE rt.is_ms_shipped = 0
	AND rc.is_replicated = 1



---- Grouped:
SELECT 
	rt.name AS TableName
	, COUNT(rc.name) AS ColumnCount
FROM sys.columns rc
	INNER JOIN sys.tables rt ON rc.OBJECT_ID = rt.OBJECT_ID
WHERE rt.is_ms_shipped = 0
	AND rc.is_replicated = 1
GROUP BY rt.name


