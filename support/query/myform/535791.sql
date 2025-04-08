BEGIN TRANSACTION 
SELECT sale_date,* FROM dbo.SALE WHERE CODE = '1000.SL.2502.00060'
SELECT sale_date,* FROM dbo.SALE_DETAIL WHERE SALE_CODE = '1000.SL.2502.00060'

UPDATE dbo.SALE SET SALE_DATE = '2025-02-12 00:00:00.000', mod_date = GETDATE() ,mod_by = 'MTN_FAUZAN', mod_ip_address = 'MYFORM-535791' WHERE CODE = '1000.SL.2502.00060'
UPDATE dbo.SALE_DETAIL SET SALE_DATE = '2025-02-20 00:00:00.000', mod_date = GETDATE() ,mod_by = 'MTN_FAUZAN', mod_ip_address = 'MYFORM-535791' WHERE SALE_CODE = '1000.SL.2502.00060'

SELECT sale_date,* FROM dbo.SALE WHERE CODE = '1000.SL.2502.00060'
SELECT sale_date,* FROM dbo.SALE_DETAIL WHERE SALE_CODE = '1000.SL.2502.00060'


DECLARE @val VARCHAR(50);

DECLARE reff_cursor CURSOR FOR
SELECT VAL
FROM (
    VALUES
    (null)
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
        'MTN MyForm 535791'
        ,'Revisi Sell Request Date dan Sell Date'
        ,'SALE'
        ,'1000.SL.2502.00060'
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