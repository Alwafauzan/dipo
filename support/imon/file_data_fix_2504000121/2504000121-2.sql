BEGIN TRANSACTION 
declare 
    @plat_no NVARCHAR(50) = 'B2536PIM',
    @nama_col1 NVARCHAR(200) = 'plat_no',
    @nama_col2 NVARCHAR(200) = 'FA_REFF_NO_01',
    @notlike1 NVARCHAR(50) = 'xx',
    @notlike2 NVARCHAR(50) = 'temp',
    @notlike3 NVARCHAR(50) = 'rpt',
    @db NVARCHAR(100),
    @query NVARCHAR(MAX)

DECLARE db_cursor CURSOR FOR 
    SELECT name FROM sys.databases 
    WHERE name IN ('IFINOPL', 'IFINPROC', 'IFINDOC', 'IFINAMS')

OPEN db_cursor
FETCH NEXT FROM db_cursor INTO @db

WHILE @@FETCH_STATUS = 0
BEGIN
    SET @query = '
    USE [' + @db + '];
    DECLARE @sql NVARCHAR(MAX) = '''';

    SELECT @sql = @sql + 
---------------------------------------------------------------------------------------------------------------------------------------		
        ''
		USE [' + @db + '];
		IF EXISTS (SELECT 1 FROM ['' + TABLE_NAME + ''] WHERE ['' + COLUMN_NAME + ''] = ''''' + REPLACE(@plat_no, '''', '''''') + ''''')
        BEGIN
            SELECT ''''[' + @db + ']'''','''''' + COLUMN_NAME + '''''' AS ColumnName, '''''' + TABLE_NAME + '''''' AS TableName, * 
            FROM ['' + TABLE_NAME + '']
            WHERE ['' + COLUMN_NAME + ''] = ''''' + REPLACE(@plat_no, '''', '''''') + ''''';
        END; ''
---------------------------------------------------------------------------------------------------------------------------------------
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE (COLUMN_NAME LIKE ''%' + @nama_col1 + '%'' OR COLUMN_NAME LIKE ''%' + @nama_col2 + '%'')
      AND TABLE_NAME NOT LIKE ''%' + @notlike1 + '%'' 
      AND TABLE_NAME NOT LIKE ''%' + @notlike2 + '%'' 
      AND TABLE_NAME NOT LIKE ''%' + @notlike3 + '%''

    EXEC (@sql);
	--print (@sql);'

    EXEC(@query)

    FETCH NEXT FROM db_cursor INTO @db
END

CLOSE db_cursor
DEALLOCATE db_cursor
ROLLBACK TRANSACTION 