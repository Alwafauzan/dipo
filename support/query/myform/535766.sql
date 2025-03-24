BEGIN TRANSACTION 
select BILLING_AMOUNT,* FROM dbo.AGREEMENT_ASSET_AMORTIZATION where AGREEMENT_NO = '0001771.4.01.01.2024'
update dbo.AGREEMENT_ASSET_AMORTIZATION set BILLING_AMOUNT =  3257143, mod_date = GETDATE() ,mod_by = 'MTN_FAUZAN', mod_ip_address = 'MYFORM-535766' where AGREEMENT_NO = '0001771.4.01.01.2024' and BILLING_NO = 14
select BILLING_AMOUNT,* FROM dbo.AGREEMENT_ASSET_AMORTIZATION where AGREEMENT_NO = '0001771.4.01.01.2024'



DECLARE @val VARCHAR(50);

DECLARE reff_cursor CURSOR FOR
SELECT VAL
FROM (
    VALUES
    ('-')
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
        'MTN MyForm 535766'
        ,'Req Revisi Billing Amount 0001771/4/01/01/202 PT INBISCO NIAGATAMA SEMESTA pada billing ke-14 sesuai PO lessee (terlampir) : Rp 3.257.143'
        ,'AGREEMENT_ASSET_AMORTIZATION'
        ,'0001771.4.01.01.2024'
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
