USE [SQLMonitor]
GO

IF OBJECT_ID(N'[Reporting].[uspListDatabaseTableColumns]') IS NOT NULL
DROP PROCEDURE [Reporting].[uspListDatabaseTableColumns] 
GO

CREATE PROCEDURE [Reporting].[uspListDatabaseTableColumns] 
    @ServerName nvarchar(128) = '',
    @DatabaseName nvarchar(128) = '',
    @TableSchema nvarchar(128) = '',
    @TableName nvarchar(128) = '',
    @ColumnName nvarchar(128) = ''
AS
BEGIN
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
    SET NOCOUNT ON;

/*
DECLARE @ServerName nvarchar(128) = '',
        @DatabaseName nvarchar(128) = '',
        @TableSchema nvarchar(128) = '',
        @TableName nvarchar(128) = '',
        @ColumnName nvarchar(128) = 'name';
*/
SELECT TOP(1000) [ServerName]
      ,[DatabaseName]
      ,[TableSchema]
      ,[TableName]
      ,[ColumnName]
      ,[OrdinalPosition]
      ,[DataType]
      ,[LengthOrPrecision]
FROM [Monitor].[DatabaseTableColumns]
WHERE [ServerName] LIKE COALESCE(NULLIF(@ServerName, ''), [ServerName])
  AND [DatabaseName] LIKE COALESCE(NULLIF(@DatabaseName, ''), [DatabaseName])
  AND [TableSchema] LIKE COALESCE(NULLIF(@TableSchema, ''), [TableSchema])
  AND [TableName] LIKE COALESCE(NULLIF(@TableName, ''), [TableName])
  AND [ColumnName] LIKE '%' + COALESCE(NULLIF(@ColumnName, ''), [ColumnName]) + '%'
ORDER BY [ServerName]
      ,[DatabaseName]
      ,[TableSchema]
      ,[TableName]
      ,[ColumnName]
      ,[OrdinalPosition];

END
GO

-- EXEC [SQLMonitor].[Reporting].[uspListDatabaseTableColumns] 
-- EXEC [SQLMonitor].[Reporting].[uspListDatabaseTableColumns] @ServerName='STGDGLSQLAPP02'
-- EXEC [SQLMonitor].[Reporting].[uspListDatabaseTableColumns] @ColumnName = 'name'
-- EXEC [SQLMonitor].[Reporting].[uspListDatabaseTableColumns] @ServerName='CFSDGLBISQL01', @ColumnName = 'account'


USE [master]
GO
