BEGIN TRANSACTION 
USE IFINOPL
DECLARE  @1 NVARCHAR(50) = REPLACE('0003699/4/10/01/2025','/','.')
		,@2 NVARCHAR(50) = REPLACE('0003631/4/10/12/2024','/','.')
--SELECT	AGREEMENT_STATUS,ASSET_STATUS,BILLING_NO,FA_REFF_NO_01,AGREEMENT_ASSET.AGREEMENT_NO,AGREEMENT_ASSET.ASSET_NO,AGREEMENT_ASSET.FIRST_PAYMENT_TYPE,AGREEMENT_ASSET.BILLING_TYPE,HANDOVER_BAST_DATE,DUE_DATE,BILLING_DATE,BILLING_AMOUNT,dbo.AGREEMENT_ASSET_AMORTIZATION.INVOICE_NO,INVOICE_STATUS,MATURITY_DATE, dbo.AGREEMENT_ASSET_AMORTIZATION.MOD_BY
----SELECT	dbo.AGREEMENT_ASSET.*
--FROM	dbo.AGREEMENT_ASSET_AMORTIZATION 
--JOIN	dbo.AGREEMENT_ASSET ON AGREEMENT_ASSET.ASSET_NO = AGREEMENT_ASSET_AMORTIZATION.ASSET_NO
--JOIN	dbo.AGREEMENT_INFORMATION ON AGREEMENT_INFORMATION.AGREEMENT_NO = AGREEMENT_ASSET.AGREEMENT_NO
--JOIN	dbo.AGREEMENT_MAIN ON AGREEMENT_MAIN.AGREEMENT_NO = AGREEMENT_ASSET.AGREEMENT_NO
--LEFT JOIN	dbo.INVOICE ON INVOICE.INVOICE_NO = AGREEMENT_ASSET_AMORTIZATION.INVOICE_NO
--WHERE	AGREEMENT_ASSET.AGREEMENT_NO = @1 AND FA_REFF_NO_01 = 'B9544PXA'
--ORDER BY BILLING_NO  ASC

--UPDATE 	dbo.AGREEMENT_ASSET_AMORTIZATION SET BILLING_AMOUNT = 138710, MOD_BY = 'MTN-FAUZAN', MOD_DATE = GETDATE(), MOD_IP_ADDRESS = 'imon-2504000113'
--WHERE 	AGREEMENT_NO = @1 AND ASSET_NO = '2010.OPLAA.2411.000052' AND BILLING_NO = 1
--UPDATE 	dbo.AGREEMENT_ASSET_AMORTIZATION SET BILLING_AMOUNT = 4161290, MOD_BY = 'MTN-FAUZAN', MOD_DATE = GETDATE(), MOD_IP_ADDRESS = 'imon-2504000113'
--WHERE 	AGREEMENT_NO = @1 AND ASSET_NO = '2010.OPLAA.2411.000052' AND BILLING_NO = 37

--SELECT	AGREEMENT_STATUS,ASSET_STATUS,BILLING_NO,FA_REFF_NO_01,AGREEMENT_ASSET.AGREEMENT_NO,AGREEMENT_ASSET.ASSET_NO,AGREEMENT_ASSET.FIRST_PAYMENT_TYPE,AGREEMENT_ASSET.BILLING_TYPE,HANDOVER_BAST_DATE,DUE_DATE,BILLING_DATE,BILLING_AMOUNT,dbo.AGREEMENT_ASSET_AMORTIZATION.INVOICE_NO,INVOICE_STATUS,MATURITY_DATE, dbo.AGREEMENT_ASSET_AMORTIZATION.MOD_BY
----SELECT	dbo.AGREEMENT_ASSET.*
--FROM		dbo.AGREEMENT_ASSET_AMORTIZATION 
--JOIN		dbo.AGREEMENT_ASSET ON AGREEMENT_ASSET.ASSET_NO = AGREEMENT_ASSET_AMORTIZATION.ASSET_NO
--JOIN		dbo.AGREEMENT_INFORMATION ON AGREEMENT_INFORMATION.AGREEMENT_NO = AGREEMENT_ASSET.AGREEMENT_NO
--JOIN		dbo.AGREEMENT_MAIN ON AGREEMENT_MAIN.AGREEMENT_NO = AGREEMENT_ASSET.AGREEMENT_NO
--LEFT JOIN	dbo.INVOICE ON INVOICE.INVOICE_NO = AGREEMENT_ASSET_AMORTIZATION.INVOICE_NO
--WHERE		AGREEMENT_ASSET.AGREEMENT_NO = @1 AND FA_REFF_NO_01 = 'B9544PXA'
--ORDER BY 	BILLING_NO  ASC

SELECT	AGREEMENT_STATUS,ASSET_STATUS,BILLING_NO,FA_REFF_NO_01,AGREEMENT_ASSET.AGREEMENT_NO,AGREEMENT_ASSET.ASSET_NO,AGREEMENT_ASSET.FIRST_PAYMENT_TYPE,AGREEMENT_ASSET.BILLING_TYPE,HANDOVER_BAST_DATE,DUE_DATE,BILLING_DATE,BILLING_AMOUNT,dbo.AGREEMENT_ASSET_AMORTIZATION.INVOICE_NO,INVOICE_STATUS,MATURITY_DATE, dbo.AGREEMENT_ASSET_AMORTIZATION.MOD_BY
--SELECT	dbo.AGREEMENT_ASSET.*
FROM	dbo.AGREEMENT_ASSET_AMORTIZATION 
JOIN	dbo.AGREEMENT_ASSET ON AGREEMENT_ASSET.ASSET_NO = AGREEMENT_ASSET_AMORTIZATION.ASSET_NO
JOIN	dbo.AGREEMENT_INFORMATION ON AGREEMENT_INFORMATION.AGREEMENT_NO = AGREEMENT_ASSET.AGREEMENT_NO
JOIN	dbo.AGREEMENT_MAIN ON AGREEMENT_MAIN.AGREEMENT_NO = AGREEMENT_ASSET.AGREEMENT_NO
LEFT JOIN	dbo.INVOICE ON INVOICE.INVOICE_NO = AGREEMENT_ASSET_AMORTIZATION.INVOICE_NO
WHERE	AGREEMENT_ASSET.AGREEMENT_NO = @2 AND FA_REFF_NO_01 = 'B9679PXA'
ORDER BY BILLING_NO  ASC

UPDATE 	dbo.AGREEMENT_ASSET_AMORTIZATION SET BILLING_AMOUNT = 277419, MOD_BY = 'MTN-FAUZAN', MOD_DATE = GETDATE(), MOD_IP_ADDRESS = 'imon-2504000113' 
WHERE 	AGREEMENT_NO = @2 AND ASSET_NO = '2010.OPLAA.2412.000180' AND BILLING_NO = 2
UPDATE 	dbo.AGREEMENT_ASSET_AMORTIZATION SET BILLING_AMOUNT = 4022581, MOD_BY = 'MTN-FAUZAN', MOD_DATE = GETDATE(), MOD_IP_ADDRESS = 'imon-2504000113' 
WHERE 	AGREEMENT_NO = @2 AND ASSET_NO = '2010.OPLAA.2412.000180' AND BILLING_NO = 37

SELECT	AGREEMENT_STATUS,ASSET_STATUS,BILLING_NO,FA_REFF_NO_01,AGREEMENT_ASSET.AGREEMENT_NO,AGREEMENT_ASSET.ASSET_NO,AGREEMENT_ASSET.FIRST_PAYMENT_TYPE,AGREEMENT_ASSET.BILLING_TYPE,HANDOVER_BAST_DATE,DUE_DATE,BILLING_DATE,BILLING_AMOUNT,dbo.AGREEMENT_ASSET_AMORTIZATION.INVOICE_NO,INVOICE_STATUS,MATURITY_DATE, dbo.AGREEMENT_ASSET_AMORTIZATION.MOD_BY
--SELECT	dbo.AGREEMENT_ASSET.*
FROM		dbo.AGREEMENT_ASSET_AMORTIZATION 
JOIN		dbo.AGREEMENT_ASSET ON AGREEMENT_ASSET.ASSET_NO = AGREEMENT_ASSET_AMORTIZATION.ASSET_NO
JOIN		dbo.AGREEMENT_INFORMATION ON AGREEMENT_INFORMATION.AGREEMENT_NO = AGREEMENT_ASSET.AGREEMENT_NO
JOIN		dbo.AGREEMENT_MAIN ON AGREEMENT_MAIN.AGREEMENT_NO = AGREEMENT_ASSET.AGREEMENT_NO
LEFT JOIN	dbo.INVOICE ON INVOICE.INVOICE_NO = AGREEMENT_ASSET_AMORTIZATION.INVOICE_NO
WHERE		AGREEMENT_ASSET.AGREEMENT_NO = @2 AND FA_REFF_NO_01 = 'B9679PXA'
ORDER BY 	BILLING_NO  ASC

ROLLBACK TRANSACTION 

--B9679PXA
--B9544PXA
