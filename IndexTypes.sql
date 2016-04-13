
SELECT 
    s.Name AS SchemaName
    , t.NAME AS TableName
	, i.name AS IndexName
	---- CLUSTERED COLUMNSTORE
	, i.type_desc AS IndexType
    , p.rows AS RowCounts
    , SUM(a.total_pages) * 8 AS TotalSpaceKB
    , SUM(a.used_pages) * 8 AS UsedSpaceKB
    , (SUM(a.total_pages) - SUM(a.used_pages)) * 8 AS UnusedSpaceKB
FROM sys.tables t
	INNER JOIN sys.schemas s ON s.schema_id = t.schema_id
	INNER JOIN sys.indexes i ON t.OBJECT_ID = i.object_id
	INNER JOIN sys.partitions p ON i.object_id = p.OBJECT_ID AND i.index_id = p.index_id
	INNER JOIN sys.allocation_units a ON p.partition_id = a.container_id
WHERE 
	--i.type_desc <> 'HEAP'
	i.type_desc = 'CLUSTERED COLUMNSTORE'
GROUP BY t.Name, s.Name, i.name, i.type_desc, p.Rows
ORDER BY p.rows DESC
