DECLARE @srv TABLE (ServerName VARCHAR(100))
INSERT INTO @srv VALUES (@@SERVERNAME)

SELECT 
	tt.ServerName
	, t.Column
FROM OtherTable t
	CROSS APPLY @srv tt
