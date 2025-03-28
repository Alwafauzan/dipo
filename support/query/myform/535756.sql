BEGIN TRANSACTION 
SELECT * FROM dbo.AGREEMENT_ASSET_AMORTIZATION WHERE AGREEMENT_NO = '0001217.4.01.01.2023'
update dbo.AGREEMENT_ASSET_AMORTIZATION set DUE_DATE = '2025-03-31', BILLING_DATE = '2025-03-31', BILLING_AMOUNT = 6000000 ,mod_date = GETDATE() ,mod_by = 'MTN_FAUZAN', mod_ip_address = 'MYFORM-535756' where AGREEMENT_NO = '0001217.4.01.01.2023' and BILLING_NO = 25
update dbo.AGREEMENT_ASSET_AMORTIZATION set BILLING_AMOUNT = 3290323 , mod_date = GETDATE() ,mod_by = 'MTN_FAUZAN', mod_ip_address = 'MYFORM-535756' where AGREEMENT_NO = '0001217.4.01.01.2023' and BILLING_NO = 26
SELECT * FROM dbo.AGREEMENT_ASSET_AMORTIZATION WHERE AGREEMENT_NO = '0001217.4.01.01.2023'
-------------------------------------------------------------------------------------------------
SELECT * FROM dbo.AGREEMENT_ASSET_AMORTIZATION WHERE AGREEMENT_NO = '0001279.4.01.01.2023'
update dbo.AGREEMENT_ASSET_AMORTIZATION set DUE_DATE = '2025-03-31', BILLING_DATE = '2025-03-31', BILLING_AMOUNT = 5150000 ,mod_date = GETDATE() ,mod_by = 'MTN_FAUZAN', mod_ip_address = 'MYFORM-535756' where AGREEMENT_NO = '0001279.4.01.01.2023' and BILLING_NO = 25
update dbo.AGREEMENT_ASSET_AMORTIZATION set BILLING_AMOUNT = 996774 , mod_date = GETDATE() ,mod_by = 'MTN_FAUZAN', mod_ip_address = 'MYFORM-535756' where AGREEMENT_NO = '0001279.4.01.01.2023' and BILLING_NO = 26
SELECT * FROM dbo.AGREEMENT_ASSET_AMORTIZATION WHERE AGREEMENT_NO = '0001279.4.01.01.2023'

DECLARE @val VARCHAR(50);

DECLARE reff_cursor CURSOR FOR
SELECT VAL
FROM (
    VALUES
    ('0001217.4.01.01.2023')
	,('0001279.4.01.01.2023')
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
        'MTN MyForm 535756'
        ,'Req Revisi Schedule Billing 0001217/4/01/01/2023 dan 0001279/4/01/01/2023 PT. ANDIARTA MUZIZAT Dikarenakan schedule billing tidak sesuai setelah dilakukan extend 1 bulan'
        ,'AGREEMENT_ASSET_AMORTIZATION'
        ,@val
        ,null
        ,null
        ,GETDATE()
        ,'fauzan'
    );

    FETCH NEXT FROM reff_cursor INTO @val;
END

CLOSE reff_cursor;
DEALLOCATE reff_cursor;
ROLLBACK TRANSACTION