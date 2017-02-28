
SELECT 
  [name]
  , [object_id]
  , [create_date]
  , [type_desc]
FROM tempdb.sys.tables
WHERE is_ms_shipped = 0
  AND type_desc = 'USER_TABLE'
ORDER BY create_date DESC
