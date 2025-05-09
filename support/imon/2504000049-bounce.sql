--https://365dipostar.sharepoint.com/:f:/s/AttachmentForIfinancing/EhkgJKCOFbxDiS_fc-KpeykBLOWwdPOCniC97rSiCJnkRw?e=phKLNt
--Dear IMS Support, Revisi billing type, payment type, nominal sewa, billing schedule PT Berkah Auto Raya
BEGIN TRANSACTION 
USE IFINOPL
DECLARE  @1 NVARCHAR(50) = REPLACE('0001494/4/01/09/2023','/','.')
		,@2 NVARCHAR(50) = REPLACE('0001911/4/10/02/2024','/','.')
		,@3 NVARCHAR(50) = REPLACE('0001763/4/10/01/2024','/','.')
		,@4 NVARCHAR(50) = REPLACE('0001707/4/10/01/2024','/','.')
		,@5 NVARCHAR(50) = REPLACE('0001708/4/10/01/2024','/','.')
SELECT	LEASE_ROUNDED_AMOUNT,BILLING_NO,AGREEMENT_ASSET.AGREEMENT_NO,AGREEMENT_ASSET.ASSET_NO,FIRST_PAYMENT_TYPE,BILLING_TYPE,HANDOVER_BAST_DATE,DUE_DATE,BILLING_DATE,BILLING_AMOUNT,dbo.AGREEMENT_ASSET_AMORTIZATION.INVOICE_NO,INVOICE_STATUS,MATURITY_DATE,AGREEMENT_ASSET_AMORTIZATION.MOD_BY
FROM	dbo.AGREEMENT_ASSET_AMORTIZATION 
JOIN	dbo.AGREEMENT_ASSET ON AGREEMENT_ASSET.AGREEMENT_NO = AGREEMENT_ASSET_AMORTIZATION.AGREEMENT_NO
JOIN	dbo.AGREEMENT_INFORMATION ON AGREEMENT_INFORMATION.AGREEMENT_NO = AGREEMENT_ASSET.AGREEMENT_NO
LEFT JOIN	dbo.INVOICE ON INVOICE.INVOICE_NO = AGREEMENT_ASSET_AMORTIZATION.INVOICE_NO
WHERE	AGREEMENT_ASSET.AGREEMENT_NO IN (
 @1
,@2
,@3
,@4
,@5
)
ORDER BY AGREEMENT_ASSET_AMORTIZATION.AGREEMENT_NO, BILLING_NO ASC

UPDATE dbo.AGREEMENT_ASSET_AMORTIZATION
SET DUE_DATE = DATEADD(MONTH,-1,DUE_DATE), MOD_BY = 'MTN-FAUZAN', MOD_DATE = GETDATE(), MOD_IP_ADDRESS = 'imon-2504000049' 
WHERE AGREEMENT_NO = @1 AND BILLING_NO >=3 AND BILLING_NO < 12

UPDATE dbo.AGREEMENT_ASSET_AMORTIZATION
SET DUE_DATE = DATEADD(MONTH,-1,DUE_DATE), MOD_BY = 'MTN-FAUZAN', MOD_DATE = GETDATE(), MOD_IP_ADDRESS = 'imon-2504000049' 
WHERE AGREEMENT_NO = @1 AND BILLING_NO >12 AND BILLING_NO < 17
---------------------------------------------------------------------------------------------------------------------------------
UPDATE dbo.AGREEMENT_ASSET_AMORTIZATION
SET BILLING_DATE = EOMONTH(DATEADD(MONTH,1,BILLING_DATE)), MOD_BY = 'MTN-FAUZAN', MOD_DATE = GETDATE(), MOD_IP_ADDRESS = 'imon-2504000049' 
WHERE AGREEMENT_NO = @2 AND BILLING_NO >=2
---------------------------------------------------------------------------------------------------------------------------------
UPDATE dbo.AGREEMENT_ASSET_AMORTIZATION
SET DUE_DATE = DATEADD(MONTH,-1,DUE_DATE),BILLING_DATE = DATEADD(MONTH,-1,BILLING_DATE), MOD_BY = 'MTN-FAUZAN', MOD_DATE = GETDATE(), MOD_IP_ADDRESS = 'imon-2504000049' 
WHERE AGREEMENT_NO = @3 AND BILLING_NO >=19
INSERT INTO AGREEMENT_ASSET_AMORTIZATION (AGREEMENT_NO, BILLING_NO, ASSET_NO, DUE_DATE, BILLING_DATE, BILLING_AMOUNT, DESCRIPTION, CRE_DATE, CRE_BY, CRE_IP_ADDRESS, MOD_DATE, MOD_BY, MOD_IP_ADDRESS) VALUES
(@3, 25 , '2010.OPLAA.2401.000092', '2026-12-29', '2027-01-29', 5000000, 'Billing ke 25  dari Periode 23/09/2024 Sampai dengan 22/09/2025', GETDATE(), 'inject-fauzan', 'MYFORM-542079', GETDATE(), 'inject-fauzan', 'MYFORM-542079')
---------------------------------------------------------------------------------------------------------------------------------
UPDATE dbo.AGREEMENT_ASSET_AMORTIZATION
SET DUE_DATE = DATEADD(MONTH,-1,DUE_DATE),BILLING_DATE = DATEADD(MONTH,-1,BILLING_DATE), MOD_BY = 'MTN-FAUZAN', MOD_DATE = GETDATE(), MOD_IP_ADDRESS = 'imon-2504000049' 
WHERE AGREEMENT_NO = @4 AND BILLING_NO >=4
INSERT INTO AGREEMENT_ASSET_AMORTIZATION (AGREEMENT_NO, BILLING_NO, ASSET_NO, DUE_DATE, BILLING_DATE, BILLING_AMOUNT, DESCRIPTION, CRE_DATE, CRE_BY, CRE_IP_ADDRESS, MOD_DATE, MOD_BY, MOD_IP_ADDRESS) VALUES
(@4, 25 , '2010.OPLAA.2401.000014', '2026-12-19', '2027-01-19', 10800000, 'Billing ke 25  dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079')
---------------------------------------------------------------------------------------------------------------------------------
UPDATE dbo.AGREEMENT_ASSET_AMORTIZATION
SET DUE_DATE = DATEADD(MONTH,-1,DUE_DATE),BILLING_DATE = DATEADD(MONTH,-1,BILLING_DATE), MOD_BY = 'MTN-FAUZAN', MOD_DATE = GETDATE(), MOD_IP_ADDRESS = 'imon-2504000049' 
WHERE AGREEMENT_NO = @4 AND BILLING_NO >=4
INSERT INTO AGREEMENT_ASSET_AMORTIZATION (AGREEMENT_NO, BILLING_NO, ASSET_NO, DUE_DATE, BILLING_DATE, BILLING_AMOUNT, DESCRIPTION, CRE_DATE, CRE_BY, CRE_IP_ADDRESS, MOD_DATE, MOD_BY, MOD_IP_ADDRESS) VALUES
(@5, 25 , '2010.OPLAA.2401.000015', '2026-12-19', '2027-01-19', 10800000, 'Billing ke 25  dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079')

SELECT	LEASE_ROUNDED_AMOUNT,BILLING_NO,AGREEMENT_ASSET.AGREEMENT_NO,AGREEMENT_ASSET.ASSET_NO,FIRST_PAYMENT_TYPE,BILLING_TYPE,HANDOVER_BAST_DATE,DUE_DATE,BILLING_DATE,BILLING_AMOUNT,dbo.AGREEMENT_ASSET_AMORTIZATION.INVOICE_NO,INVOICE_STATUS,MATURITY_DATE,AGREEMENT_ASSET_AMORTIZATION.MOD_BY
FROM	dbo.AGREEMENT_ASSET_AMORTIZATION 
JOIN	dbo.AGREEMENT_ASSET ON AGREEMENT_ASSET.AGREEMENT_NO = AGREEMENT_ASSET_AMORTIZATION.AGREEMENT_NO
JOIN	dbo.AGREEMENT_INFORMATION ON AGREEMENT_INFORMATION.AGREEMENT_NO = AGREEMENT_ASSET.AGREEMENT_NO
LEFT JOIN	dbo.INVOICE ON INVOICE.INVOICE_NO = AGREEMENT_ASSET_AMORTIZATION.INVOICE_NO
WHERE	AGREEMENT_ASSET.AGREEMENT_NO in (
 @1
,@2
,@3
,@4
,@5
)
ORDER BY AGREEMENT_ASSET_AMORTIZATION.AGREEMENT_NO, BILLING_NO ASC

ROLLBACK TRANSACTION 