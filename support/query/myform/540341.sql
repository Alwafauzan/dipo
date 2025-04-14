BEGIN TRANSACTION 
SELECT			fam.REFF_NO_1,* FROM dbo.DOCUMENT_PENDING
LEFT JOIN		replacement_request_detail rrq ON rrq.ASSET_NO = DOCUMENT_PENDING.ASSET_NO
left join		dbo.fixed_asset_main fam on (fam.asset_no = rrq.asset_no) 
WHERE			DOCUMENT_PENDING.COVER_NOTE_NO LIKE '%966%'

UPDATE	replacement_request_detail 
SET		REPLACEMENT_REQUEST_ID	= 3531		
		,mod_date 				= GETDATE() 
		,mod_by 				= 'MTN_FAUZAN'
		,mod_ip_address 		= 'MYFORM-540341'   
WHERE	ID IN (14424,14414)


SELECT			fam.REFF_NO_1,* FROM dbo.DOCUMENT_PENDING
LEFT JOIN		replacement_request_detail rrq ON rrq.ASSET_NO = DOCUMENT_PENDING.ASSET_NO
left join		dbo.fixed_asset_main fam on (fam.asset_no = rrq.asset_no) 
WHERE			DOCUMENT_PENDING.COVER_NOTE_NO LIKE '%966%'

DECLARE @val VARCHAR(50);

DECLARE reff_cursor CURSOR FOR
SELECT VAL
FROM (
    VALUES
    ('')
	--,('')
	--,('')
	--,('')
) AS RefNos(VAL);

OPEN reff_cursor;
FETCH NEXT FROM reff_cursor INTO @val;

WHILE @@FETCH_STATUS = 0
BEGIN
    INSERT INTO MTN_DATA_DSF_LOG
    (   
        MAINTENANCE_NAME
        ,REMARK
        ,TABEL_UTAMA
        ,REFF_1
        ,REFF_2
        ,REFF_3
        ,CRE_DATE
        ,CRE_BY
    )
    VALUES
    (   
        'MTN MyForm 540341'
        ,'Issue data kendaraan yang tidak lengkap di menu Temporary Request'
        ,'replacement_request_detail'
        ,'No. 966/SPBPKB/01/2025'
        ,@val
        ,null
        ,GETDATE()
        ,'fauzan'
    );

    FETCH NEXT FROM reff_cursor INTO @val;
END

CLOSE reff_cursor;
DEALLOCATE reff_cursor;
ROLLBACK TRANSACTION 