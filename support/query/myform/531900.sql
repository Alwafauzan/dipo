BEGIN TRANSACTION 

SELECT	FA_REFF_NO_01,HANDOVER_BAST_DATE,FIRST_PAYMENT_TYPE,DUE_DATE,BILLING_DATE,BILLING_AMOUNT,INVOICE_NO,MATURITY_DATE,* 
FROM	dbo.AGREEMENT_ASSET_AMORTIZATION 
JOIN	dbo.AGREEMENT_ASSET ON AGREEMENT_ASSET.ASSET_NO = AGREEMENT_ASSET_AMORTIZATION.ASSET_NO
JOIN	AGREEMENT_INFORMATION ON AGREEMENT_INFORMATION.AGREEMENT_NO = AGREEMENT_ASSET.AGREEMENT_NO 
WHERE	AGREEMENT_ASSET_AMORTIZATION.AGREEMENT_NO = (SELECT REPLACE('0003609/4/10/12/2024', '/', '.'))

UPDATE	AGREEMENT_ASSET 
SET		HANDOVER_BAST_DATE	= '2025-01-28'
		,mod_date 			= GETDATE() 
		,mod_by 			= 'MTN_FAUZAN'
		,mod_ip_address 	= 'MYFORM-531900' 
WHERE	ASSET_NO			= '2010.OPLAA.2412.000090'
UPDATE	dbo.AGREEMENT_ASSET_AMORTIZATION 
SET		DUE_DATE			= EOMONTH(DATEADD(MONTH,1, DUE_DATE))
		,BILLING_DATE		= EOMONTH(DATEADD(MONTH,1, DUE_DATE))
		,mod_date 			= GETDATE() 
		,mod_by 			= 'MTN_FAUZAN'
		,mod_ip_address 	= 'MYFORM-531900'  
WHERE	ASSET_NO = '2010.OPLAA.2412.000090'
UPDATE	dbo.AGREEMENT_INFORMATION
SET		MATURITY_DATE		= '2027-12-29'
		,mod_date 			= GETDATE() 
		,mod_by 			= 'MTN_FAUZAN'
		,mod_ip_address 	= 'MYFORM-531900'  
WHERE	AGREEMENT_NO		= '0003609.4.10.12.2024'

SELECT	FA_REFF_NO_01,HANDOVER_BAST_DATE,FIRST_PAYMENT_TYPE,DUE_DATE,BILLING_DATE,BILLING_AMOUNT,INVOICE_NO,MATURITY_DATE,* 
FROM	dbo.AGREEMENT_ASSET_AMORTIZATION 
JOIN	dbo.AGREEMENT_ASSET ON AGREEMENT_ASSET.ASSET_NO = AGREEMENT_ASSET_AMORTIZATION.ASSET_NO
JOIN	AGREEMENT_INFORMATION ON AGREEMENT_INFORMATION.AGREEMENT_NO = AGREEMENT_ASSET.AGREEMENT_NO 
WHERE	AGREEMENT_ASSET_AMORTIZATION.AGREEMENT_NO = (SELECT REPLACE('0003609/4/10/12/2024', '/', '.'))

ROLLBACK TRANSACTION 

BEGIN TRANSACTION 
SELECT	FA_REFF_NO_01,HANDOVER_BAST_DATE,FIRST_PAYMENT_TYPE,DUE_DATE,BILLING_DATE,BILLING_AMOUNT,INVOICE_NO,MATURITY_DATE,* 
FROM	dbo.AGREEMENT_ASSET_AMORTIZATION 
JOIN	dbo.AGREEMENT_ASSET ON AGREEMENT_ASSET.ASSET_NO = AGREEMENT_ASSET_AMORTIZATION.ASSET_NO
JOIN	AGREEMENT_INFORMATION ON AGREEMENT_INFORMATION.AGREEMENT_NO = AGREEMENT_ASSET.AGREEMENT_NO
WHERE AGREEMENT_ASSET_AMORTIZATION.AGREEMENT_NO = (SELECT REPLACE('0003631/4/10/12/2024', '/', '.')) AND FA_REFF_NO_01 = 'B9679PXA'

UPDATE	AGREEMENT_ASSET 
SET		HANDOVER_BAST_DATE	= '2024-12-29'
		,mod_date 			= GETDATE() 
		,mod_by 			= 'MTN_FAUZAN'
		,mod_ip_address 	= 'MYFORM-531900'  
WHERE	ASSET_NO			= '2010.OPLAA.2412.000180'
UPDATE	dbo.AGREEMENT_ASSET_AMORTIZATION
SET		DUE_DATE			= '2025-01-29'
		,BILLING_DATE		= '2025-01-29'
		,mod_date 			= GETDATE() 
		,mod_by 			= 'MTN_FAUZAN'
		,mod_ip_address 	= 'MYFORM-531900'  
WHERE	ASSET_NO = '2010.OPLAA.2412.000180' AND BILLING_NO = 1
UPDATE	dbo.AGREEMENT_ASSET_AMORTIZATION 
SET		DUE_DATE			= EOMONTH(DATEADD(MONTH,-2, DUE_DATE))
		,BILLING_DATE		= EOMONTH(DATEADD(MONTH,-2, DUE_DATE))
		,mod_date 			= GETDATE() 
		,mod_by 			= 'MTN_FAUZAN'
		,mod_ip_address 	= 'MYFORM-531900'  
WHERE	ASSET_NO = '2010.OPLAA.2412.000180' AND BILLING_NO > 1
UPDATE	dbo.AGREEMENT_INFORMATION
SET		MATURITY_DATE		= '2028-01-31'
		,mod_date 			= GETDATE() 
		,mod_by 			= 'MTN_FAUZAN'
		,mod_ip_address 	= 'MYFORM-531900'  
WHERE	AGREEMENT_NO		= '0003631.4.10.12.2024'

SELECT	FA_REFF_NO_01,HANDOVER_BAST_DATE,FIRST_PAYMENT_TYPE,DUE_DATE,BILLING_DATE,BILLING_AMOUNT,INVOICE_NO,MATURITY_DATE,* 
FROM	dbo.AGREEMENT_ASSET_AMORTIZATION 
JOIN	dbo.AGREEMENT_ASSET ON AGREEMENT_ASSET.ASSET_NO = AGREEMENT_ASSET_AMORTIZATION.ASSET_NO
JOIN	AGREEMENT_INFORMATION ON AGREEMENT_INFORMATION.AGREEMENT_NO = AGREEMENT_ASSET.AGREEMENT_NO
WHERE AGREEMENT_ASSET_AMORTIZATION.AGREEMENT_NO = (SELECT REPLACE('0003631/4/10/12/2024', '/', '.')) AND FA_REFF_NO_01 = 'B9679PXA'


DECLARE @val VARCHAR(50);

DECLARE reff_cursor CURSOR FOR
SELECT VAL
FROM (
    VALUES
    ('2010.OPLAA.2412.000090')
	,('2010.OPLAA.2412.000180')
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
        'MTN MyForm 531900'
        ,'Revisi Bast Date dan Schedule Billing Kopsi Nopol B9640PXA dan B9679PXA'
        ,'AGREEMENT_ASSET_AMORTIZATION'
        ,'531900'
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