SELECT			reff_no_1,* FROM dbo.DOCUMENT_PENDING
LEFT JOIN		replacement_request_detail rrq ON rrq.ASSET_NO = DOCUMENT_PENDING.ASSET_NO
left join		dbo.fixed_asset_main fam on (fam.asset_no = rrq.asset_no) 
WHERE			DOCUMENT_PENDING.COVER_NOTE_NO LIKE '%966%'
-- -------------------------------------------------------------------------------------------------------------------------
	select		rrq.asset_no
				,fam.asset_name
				,fam.reff_no_1
				,fam.reff_no_2
				,fam.reff_no_3
				,rrq.replacement_code
				,rrq.document_main_code
				,rrq.status
				,*
	from		replacement_request_detail rrq
				left join dbo.fixed_asset_main fam on (fam.asset_no = rrq.asset_no)
	where		rrq.replacement_request_id = '3511'

	SELECT STATUS,* FROM dbo.REPLACEMENT_REQUEST WHERE COVER_NOTE_NO LIKE '%966%'
-- -------------------------------------------------------------------------------------------------------------------------
declare
	@p_nama_column				nvarchar(200) = 'COVER_NOTE_NO'
	,@p_not_like_1_opsional		nvarchar(50) = 'xx'
	,@p_not_like_2_opsional		nvarchar(50) = 'temp'
	,@p_not_like_3_opsional		nvarchar(50) = 'rpt'
-- WITH ENCRYPTION, RECOMPILE, EXECUTE AS CALLER|SELF|OWNER| 'user_name'
    set @p_not_like_1_opsional = case when @p_not_like_1_opsional = '' then ' ' else @p_not_like_1_opsional end
    set @p_not_like_2_opsional = case when @p_not_like_2_opsional = '' then ' ' else @p_not_like_2_opsional end
    set @p_not_like_3_opsional = case when @p_not_like_3_opsional = '' then ' ' else @p_not_like_3_opsional end

    select TABLE_NAME, COLUMN_NAME
	from INFORMATION_SCHEMA.COLUMNS
	where COLUMN_NAME LIKE  '%'+@p_nama_column+'%'	
	and TABLE_NAME not like '%'+@p_not_like_1_opsional+'%' -- Opsional
	and TABLE_NAME not like '%'+@p_not_like_2_opsional+'%' -- Opsional
	and TABLE_NAME not like '%'+@p_not_like_3_opsional+'%' -- Opsional