DECLARE @reff_no_01 VARCHAR(50);

DECLARE reff_cursor CURSOR FOR
SELECT FA_REFF_NO_01
FROM (
    VALUES
    ('B9260PXA'),
    ('B9262PXA'),
    ('B9257PXA'),
    ('B9224PXA'),
    ('B9255PXA')
) AS RefNos(FA_REFF_NO_01);

OPEN reff_cursor;
FETCH NEXT FROM reff_cursor INTO @reff_no_01;

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
        'MTN MyForm 531367'
        ,'revisi perubahan billing date, dan nominal prorate awal serta akhir dikarenakan lessee request adanya perubahan billing date, dan nominal prorate awal serta ahir'
        ,'AGREEMENT_ASSET_AMORTIZATION'
        ,'0002745.4.38.08.2024'
        ,@reff_no_01
        ,null
        ,GETDATE()
        ,'fauzan'
    );

    FETCH NEXT FROM reff_cursor INTO @reff_no_01;
END

CLOSE reff_cursor;
DEALLOCATE reff_cursor;