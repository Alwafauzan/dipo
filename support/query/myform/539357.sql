BEGIN TRANSACTION 
SELECT * FROM dbo.AGREEMENT_ASSET_AMORTIZATION WHERE AGREEMENT_NO = '0002139.4.10.03.2024'
UPDATE dbo.AGREEMENT_ASSET_AMORTIZATION SET DUE_DATE = EOMONTH(DUE_DATE), BILLING_DATE = EOMONTH(DUE_DATE), mod_date = GETDATE() ,mod_by = 'MTN_FAUZAN', mod_ip_address = 'MYFORM-539357' WHERE ASSET_NO = '2010.OPLAA.2402.000006'
SELECT * FROM dbo.AGREEMENT_ASSET_AMORTIZATION WHERE AGREEMENT_NO = '0002139.4.10.03.2024'	

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
        'MTN MyForm 539357'
        ,'Revisi Schedule Billing PT. Lion Express 0002139/4/10/03/2024 Dikarenakan Schedule Billing ada request perubahan dari lessee'
        ,'SALE'
        ,'2010.OPLAA.2402.000006'
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