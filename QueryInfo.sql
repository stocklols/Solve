SELECT 
	session_id AS SessionID
    , [text] AS QueryText
	, blocking_session_id AS SessionID
	, total_elapsed_time AS TotalTime
	, wait_type AS WaitType
	, last_wait_type AS LastWaitType
	, [status] AS QueryStatus
	, *
FROM sys.dm_exec_requests  
    CROSS APPLY sys.dm_exec_sql_text(sql_handle)
WHERE [text] NOT LIKE '%CROSS APPLY sys.dm_exec_sql_text(sql_handle)%'
