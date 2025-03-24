DECLARE @val VARCHAR(50);

DECLARE reff_cursor CURSOR FOR
SELECT VAL
FROM (
    VALUES
    ('4120038983')
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
        'MTN MyForm 523399'
        ,'revisi perubahan billing date, dan nominal prorate awal serta akhir dikarenakan lessee request adanya perubahan billing date, dan nominal prorate awal serta ahir'
        ,'AGREEMENT_ASSET_AMORTIZATION'
        ,'2008.OPLAA.2501.000090'
        ,@val
        ,null
        ,GETDATE()
        ,'fauzan'
    );

    FETCH NEXT FROM reff_cursor INTO @val;
END

CLOSE reff_cursor;
DEALLOCATE reff_cursor;