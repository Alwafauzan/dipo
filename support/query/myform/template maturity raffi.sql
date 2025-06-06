BEGIN TRANSACTION 
DECLARE @AGREEMENT_NO VARCHAR(50)
DECLARE @SQL VARCHAR(MAX)

SET @AGREEMENT_NO = '0000116/4/04/12/2021'

WHILE @AGREEMENT_NO <> ''
BEGIN
	EXEC dbo.xsp_mtn_hold_maturity_v2 @p_agreement_no = @AGREEMENT_NO, @p_mod_by = N'MTN-FAUZAN-540052'
	
	SET @SQL = 'SELECT ''AGREEMENT_ASSET'',ASSET_STATUS,* FROM dbo.AGREEMENT_ASSET WHERE AGREEMENT_NO = replace(''' + @AGREEMENT_NO + ''',''/'','''.''')'
	EXEC sp_executesql @SQL

	SET @SQL = 'SELECT ''AGREEMENT_MAIN'',AGREEMENT_STATUS,* FROM dbo.AGREEMENT_MAIN WHERE AGREEMENT_NO = replace(''' + @AGREEMENT_NO + ''',''/'','''.''')'
	EXEC sp_executesql @SQL

	SET @SQL = 'SELECT * FROM dbo.MTN_DATA_DSF_LOG WHERE REFF_1 = replace(''' + @AGREEMENT_NO + ''',''/'','''.''')'
	EXEC sp_executesql @SQL

	SET @AGREEMENT_NO = CASE @AGREEMENT_NO
		WHEN '0000116/4/04/12/2021' THEN '0000108/4/04/12/2021'
		WHEN '0000108/4/04/12/2021' THEN '0000113/4/04/12/2021'
		WHEN '0000113/4/04/12/2021' THEN '0000118/4/04/12/2021'
		WHEN '0000118/4/04/12/2021' THEN '0000111/4/04/12/2021'
		WHEN '0000111/4/04/12/2021' THEN '0000112/4/04/12/2021'
		ELSE ''
	END
END
ROLLBACK TRANSACTION 