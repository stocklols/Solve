---- Run on master:
CREATE LOGIN loginNAME WITH PASSWORD = 'THISISTHEWORLDSBESTPASSWORDEVAandyouwouldnguessitifyoutriedOHWAITnowihavetorememberit'

---- Run on database:
CREATE USER userNAME
	FOR LOGIN loginNAME
	WITH DEFAULT_SCHEMA = dbo
GO

---- Add user to the database owner role
EXEC sp_addrolemember N'db_owner', N'userNAME'
GO
