BEGIN TRANSACTION 
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
WHERE	AGREEMENT_ASSET.AGREEMENT_NO in (
 @1
,@2
,@3
,@4
,@5
)
ORDER BY AGREEMENT_ASSET_AMORTIZATION.AGREEMENT_NO, BILLING_NO ASC

UPDATE AGREEMENT_ASSET SET BILLING_TYPE = 'QRT', mod_date = GETDATE() ,mod_by = 'MTN_FAUZAN', mod_ip_address = 'MYFORM-542079' WHERE AGREEMENT_NO = @1
DELETE dbo.AGREEMENT_ASSET_AMORTIZATION WHERE AGREEMENT_NO = @1 AND BILLING_NO IN (3,4,5)
INSERT INTO AGREEMENT_ASSET_AMORTIZATION (AGREEMENT_NO, BILLING_NO, ASSET_NO, DUE_DATE, BILLING_DATE, BILLING_AMOUNT, DESCRIPTION, CRE_DATE, CRE_BY, CRE_IP_ADDRESS, MOD_DATE, MOD_BY, MOD_IP_ADDRESS) VALUES
(@1, 3 , '0001494.4.01.09.2023-1', '2025-04-01', '2025-02-02', 15750000, 'Billing ke 3  dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079'),
(@1, 4 , '0001494.4.01.09.2023-1', '2025-07-01', '2025-05-02', 15750000, 'Billing ke 4  dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079'),
(@1, 5 , '0001494.4.01.09.2023-1', '2025-10-01', '2025-08-02', 15750000, 'Billing ke 5  dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079'),
(@1, 6 , '0001494.4.01.09.2023-1', '2026-01-01', '2025-11-02', 15750000, 'Billing ke 6  dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079'),
(@1, 7 , '0001494.4.01.09.2023-1', '2026-04-01', '2026-02-02', 15750000, 'Billing ke 7  dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079'),
(@1, 8 , '0001494.4.01.09.2023-1', '2026-07-01', '2026-05-02', 15750000, 'Billing ke 8  dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079'),
(@1, 9 , '0001494.4.01.09.2023-1', '2026-10-01', '2026-08-02', 15750000, 'Billing ke 9  dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079'),
(@1, 10, '0001494.4.01.09.2023-1', '2027-01-01', '2026-11-02', 15750000, 'Billing ke 10 dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079'),
(@1, 11, '0001494.4.01.09.2023-1', '2027-04-01', '2027-02-02', 15750000, 'Billing ke 11 dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079'),
(@1, 12, '0001494.4.01.09.2023-1', '2027-07-01', '2027-05-02', 15750000, 'Billing ke 12 dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079'),
(@1, 13, '0001494.4.01.09.2023-1', '2027-10-01', '2027-08-02', 15750000, 'Billing ke 13 dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079'),
(@1, 14, '0001494.4.01.09.2023-1', '2028-01-01', '2027-11-02', 15750000, 'Billing ke 14 dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079'),
(@1, 15, '0001494.4.01.09.2023-1', '2028-04-01', '2028-02-02', 15750000, 'Billing ke 15 dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079'),
(@1, 16, '0001494.4.01.09.2023-1', '2028-07-01', '2028-05-02', 15750000, 'Billing ke 16 dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079'),
(@1, 17, '0001494.4.01.09.2023-1', '2028-09-22', '2028-08-02', 14175000, 'Billing ke 17 dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079');
UPDATE dbo.AGREEMENT_INFORMATION SET MATURITY_DATE = '2028-09-22' WHERE AGREEMENT_NO = @1
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
UPDATE AGREEMENT_ASSET SET BILLING_TYPE = 'QRT', mod_date = GETDATE() ,mod_by = 'MTN_FAUZAN', mod_ip_address = 'MYFORM-542079' WHERE AGREEMENT_NO = @2
DELETE dbo.AGREEMENT_ASSET_AMORTIZATION WHERE AGREEMENT_NO = @2 AND BILLING_NO IN (2,3,4)
INSERT INTO AGREEMENT_ASSET_AMORTIZATION (AGREEMENT_NO, BILLING_NO, ASSET_NO, DUE_DATE, BILLING_DATE, BILLING_AMOUNT, DESCRIPTION, CRE_DATE, CRE_BY, CRE_IP_ADDRESS, MOD_DATE, MOD_BY, MOD_IP_ADDRESS) VALUES
(@2, 2 , '2010.OPLAA.2402.000029', '2025-03-31', '2025-02-01', 36300000, 'Billing ke 2  dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079'),
(@2, 3 , '2010.OPLAA.2402.000029', '2025-06-30', '2025-05-01', 36300000, 'Billing ke 3  dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079'),
(@2, 4 , '2010.OPLAA.2402.000029', '2025-09-30', '2025-08-01', 36300000, 'Billing ke 4  dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079'),
(@2, 5 , '2010.OPLAA.2402.000029', '2025-12-31', '2025-11-01', 36300000, 'Billing ke 5  dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079'),
(@2, 6 , '2010.OPLAA.2402.000029', '2026-03-31', '2026-02-01', 36300000, 'Billing ke 6  dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079'),
(@2, 7 , '2010.OPLAA.2402.000029', '2026-06-30', '2026-05-01', 36300000, 'Billing ke 7  dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079'),
(@2, 8 , '2010.OPLAA.2402.000029', '2026-09-30', '2026-08-01', 36300000, 'Billing ke 8  dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079'),
(@2, 9 , '2010.OPLAA.2402.000029', '2026-12-31', '2026-11-01', 36300000, 'Billing ke 9  dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079'),
(@2, 10, '2010.OPLAA.2402.000029', '2027-02-28', '2027-03-01', 24200000, 'Billing ke 10 dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079')
UPDATE dbo.AGREEMENT_INFORMATION SET MATURITY_DATE = '2027-02-28' WHERE AGREEMENT_NO = @2
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
UPDATE AGREEMENT_ASSET SET BILLING_TYPE = 'MNT', FIRST_PAYMENT_TYPE = 'ARR', mod_date = GETDATE() ,mod_by = 'MTN_FAUZAN', mod_ip_address = 'MYFORM-542079' WHERE AGREEMENT_NO = @3
DELETE dbo.AGREEMENT_ASSET_AMORTIZATION WHERE AGREEMENT_NO = @3 AND BILLING_NO IN (2,3)
INSERT INTO AGREEMENT_ASSET_AMORTIZATION (AGREEMENT_NO, BILLING_NO, ASSET_NO, DUE_DATE, BILLING_DATE, BILLING_AMOUNT, DESCRIPTION, CRE_DATE, CRE_BY, CRE_IP_ADDRESS, MOD_DATE, MOD_BY, MOD_IP_ADDRESS) VALUES
(@3, 2 , '2010.OPLAA.2402.000029', '2025-01-29', '2025-02-28', 5000000, 'Billing ke 2  dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079'),
(@3, 3 , '2010.OPLAA.2402.000029', '2025-02-28', '2025-03-29', 5000000, 'Billing ke 3  dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079'),
(@3, 4 , '2010.OPLAA.2402.000029', '2025-03-29', '2025-04-29', 5000000, 'Billing ke 4  dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079'),
(@3, 5 , '2010.OPLAA.2402.000029', '2025-04-29', '2025-05-29', 5000000, 'Billing ke 5  dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079'),
(@3, 6 , '2010.OPLAA.2402.000029', '2025-05-29', '2025-06-29', 5000000, 'Billing ke 6  dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079'),
(@3, 7 , '2010.OPLAA.2402.000029', '2025-06-29', '2025-07-29', 5000000, 'Billing ke 7  dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079'),
(@3, 8 , '2010.OPLAA.2402.000029', '2025-07-29', '2025-08-29', 5000000, 'Billing ke 8  dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079'),
(@3, 9 , '2010.OPLAA.2402.000029', '2025-08-29', '2025-09-29', 5000000, 'Billing ke 9  dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079'),
(@3, 10, '2010.OPLAA.2402.000029', '2025-09-29', '2025-10-29', 5000000, 'Billing ke 10 dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079'),
(@3, 11, '2010.OPLAA.2402.000029', '2025-10-29', '2025-11-29', 5000000, 'Billing ke 11 dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079'),
(@3, 12, '2010.OPLAA.2402.000029', '2025-11-29', '2025-12-29', 5000000, 'Billing ke 12 dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079'),
(@3, 13, '2010.OPLAA.2402.000029', '2025-12-29', '2026-01-29', 5000000, 'Billing ke 13 dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079'),
(@3, 14, '2010.OPLAA.2402.000029', '2026-01-29', '2026-02-28', 5000000, 'Billing ke 14 dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079'),
(@3, 15, '2010.OPLAA.2402.000029', '2026-02-28', '2026-03-29', 5000000, 'Billing ke 15 dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079'),
(@3, 16, '2010.OPLAA.2402.000029', '2026-03-29', '2026-04-29', 5000000, 'Billing ke 16 dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079'),
(@3, 17, '2010.OPLAA.2402.000029', '2026-04-29', '2026-05-29', 5000000, 'Billing ke 17 dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079'),
(@3, 18, '2010.OPLAA.2402.000029', '2026-05-29', '2026-06-29', 5000000, 'Billing ke 18 dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079'),
(@3, 19, '2010.OPLAA.2402.000029', '2026-07-29', '2026-08-29', 5000000, 'Billing ke 19 dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079'),
(@3, 20, '2010.OPLAA.2402.000029', '2026-08-29', '2026-09-29', 5000000, 'Billing ke 20 dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079'),
(@3, 21, '2010.OPLAA.2402.000029', '2026-09-29', '2026-10-29', 5000000, 'Billing ke 21 dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079'),
(@3, 22, '2010.OPLAA.2402.000029', '2026-10-29', '2026-11-29', 5000000, 'Billing ke 22 dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079'),
(@3, 23, '2010.OPLAA.2402.000029', '2026-11-29', '2026-12-29', 5000000, 'Billing ke 23 dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079'),
(@3, 24, '2010.OPLAA.2402.000029', '2026-12-29', '2027-01-29', 5000000, 'Billing ke 24 dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079')
UPDATE dbo.AGREEMENT_INFORMATION SET MATURITY_DATE = '2027-01-29' WHERE AGREEMENT_NO = @3
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
UPDATE AGREEMENT_ASSET SET BILLING_TYPE = 'MNT', FIRST_PAYMENT_TYPE = 'ARR', mod_date = GETDATE() ,mod_by = 'MTN_FAUZAN', mod_ip_address = 'MYFORM-542079' WHERE AGREEMENT_NO = @4
DELETE dbo.AGREEMENT_ASSET_AMORTIZATION WHERE AGREEMENT_NO = @4 AND BILLING_NO IN (2,3)
INSERT INTO AGREEMENT_ASSET_AMORTIZATION (AGREEMENT_NO, BILLING_NO, ASSET_NO, DUE_DATE, BILLING_DATE, BILLING_AMOUNT, DESCRIPTION, CRE_DATE, CRE_BY, CRE_IP_ADDRESS, MOD_DATE, MOD_BY, MOD_IP_ADDRESS) VALUES
(@4, 2 , '2010.OPLAA.2402.000029', '2025-01-19', '2025-02-19', 10800000, 'Billing ke 2  dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079'),
(@4, 3 , '2010.OPLAA.2402.000029', '2025-02-19', '2025-03-19', 10800000, 'Billing ke 3  dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079'),
(@4, 4 , '2010.OPLAA.2402.000029', '2025-04-19', '2025-05-19', 10800000, 'Billing ke 4  dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079'),
(@4, 5 , '2010.OPLAA.2402.000029', '2025-05-19', '2025-06-19', 10800000, 'Billing ke 5  dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079'),
(@4, 6 , '2010.OPLAA.2402.000029', '2025-06-19', '2025-07-19', 10800000, 'Billing ke 6  dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079'),
(@4, 7 , '2010.OPLAA.2402.000029', '2025-07-19', '2025-08-19', 10800000, 'Billing ke 7  dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079'),
(@4, 8 , '2010.OPLAA.2402.000029', '2025-08-19', '2025-09-19', 10800000, 'Billing ke 8  dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079'),
(@4, 9 , '2010.OPLAA.2402.000029', '2025-09-19', '2025-10-19', 10800000, 'Billing ke 9  dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079'),
(@4, 10, '2010.OPLAA.2402.000029', '2025-10-19', '2025-11-19', 10800000, 'Billing ke 10 dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079'),
(@4, 11, '2010.OPLAA.2402.000029', '2025-11-19', '2025-12-19', 10800000, 'Billing ke 11 dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079'),
(@4, 12, '2010.OPLAA.2402.000029', '2025-12-19', '2026-01-19', 10800000, 'Billing ke 12 dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079'),
(@4, 13, '2010.OPLAA.2402.000029', '2026-01-19', '2026-02-19', 10800000, 'Billing ke 13 dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079'),
(@4, 14, '2010.OPLAA.2402.000029', '2026-02-19', '2026-03-19', 10800000, 'Billing ke 14 dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079'),
(@4, 15, '2010.OPLAA.2402.000029', '2026-03-19', '2026-04-19', 10800000, 'Billing ke 15 dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079'),
(@4, 16, '2010.OPLAA.2402.000029', '2026-04-19', '2026-05-19', 10800000, 'Billing ke 16 dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079'),
(@4, 17, '2010.OPLAA.2402.000029', '2026-05-19', '2026-06-19', 10800000, 'Billing ke 17 dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079'),
(@4, 18, '2010.OPLAA.2402.000029', '2026-06-19', '2026-07-19', 10800000, 'Billing ke 18 dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079'),
(@4, 19, '2010.OPLAA.2402.000029', '2026-07-19', '2026-08-19', 10800000, 'Billing ke 19 dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079'),
(@4, 20, '2010.OPLAA.2402.000029', '2026-08-19', '2026-09-19', 10800000, 'Billing ke 20 dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079'),
(@4, 21, '2010.OPLAA.2402.000029', '2026-09-19', '2026-10-19', 10800000, 'Billing ke 21 dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079'),
(@4, 22, '2010.OPLAA.2402.000029', '2026-10-19', '2026-11-19', 10800000, 'Billing ke 22 dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079'),
(@4, 23, '2010.OPLAA.2402.000029', '2026-11-19', '2026-12-19', 10800000, 'Billing ke 23 dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079'),
(@4, 24, '2010.OPLAA.2402.000029', '2026-12-19', '2027-01-19', 10800000, 'Billing ke 24 dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079')
UPDATE dbo.AGREEMENT_INFORMATION SET MATURITY_DATE = '2027-01-19' WHERE AGREEMENT_NO = @4
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
UPDATE AGREEMENT_ASSET SET BILLING_TYPE = 'MNT', FIRST_PAYMENT_TYPE = 'ARR', mod_date = GETDATE() ,mod_by = 'MTN_FAUZAN', mod_ip_address = 'MYFORM-542079' WHERE AGREEMENT_NO = @5
DELETE dbo.AGREEMENT_ASSET_AMORTIZATION WHERE AGREEMENT_NO = @5 AND BILLING_NO IN (2,3)
INSERT INTO AGREEMENT_ASSET_AMORTIZATION (AGREEMENT_NO, BILLING_NO, ASSET_NO, DUE_DATE, BILLING_DATE, BILLING_AMOUNT, DESCRIPTION, CRE_DATE, CRE_BY, CRE_IP_ADDRESS, MOD_DATE, MOD_BY, MOD_IP_ADDRESS) VALUES
(@5, 2 , '2010.OPLAA.2402.000029', '2025-01-19', '2025-02-19', 10800000, 'Billing ke 2  dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079'),
(@5, 3 , '2010.OPLAA.2402.000029', '2025-02-19', '2025-03-19', 10800000, 'Billing ke 3  dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079'),
(@5, 4 , '2010.OPLAA.2402.000029', '2025-04-19', '2025-05-19', 10800000, 'Billing ke 4  dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079'),
(@5, 5 , '2010.OPLAA.2402.000029', '2025-05-19', '2025-06-19', 10800000, 'Billing ke 5  dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079'),
(@5, 6 , '2010.OPLAA.2402.000029', '2025-06-19', '2025-07-19', 10800000, 'Billing ke 6  dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079'),
(@5, 7 , '2010.OPLAA.2402.000029', '2025-07-19', '2025-08-19', 10800000, 'Billing ke 7  dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079'),
(@5, 8 , '2010.OPLAA.2402.000029', '2025-08-19', '2025-09-19', 10800000, 'Billing ke 8  dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079'),
(@5, 9 , '2010.OPLAA.2402.000029', '2025-09-19', '2025-10-19', 10800000, 'Billing ke 9  dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079'),
(@5, 10, '2010.OPLAA.2402.000029', '2025-10-19', '2025-11-19', 10800000, 'Billing ke 11 dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079'),
(@5, 11, '2010.OPLAA.2402.000029', '2025-11-19', '2025-12-19', 10800000, 'Billing ke 11 dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079'),
(@5, 12, '2010.OPLAA.2402.000029', '2025-12-19', '2026-01-19', 10800000, 'Billing ke 12 dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079'),
(@5, 13, '2010.OPLAA.2402.000029', '2026-01-19', '2026-02-19', 10800000, 'Billing ke 13 dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079'),
(@5, 14, '2010.OPLAA.2402.000029', '2026-02-19', '2026-03-19', 10800000, 'Billing ke 14 dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079'),
(@5, 15, '2010.OPLAA.2402.000029', '2026-03-19', '2026-04-19', 10800000, 'Billing ke 15 dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079'),
(@5, 16, '2010.OPLAA.2402.000029', '2026-04-19', '2026-05-19', 10800000, 'Billing ke 16 dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079'),
(@5, 17, '2010.OPLAA.2402.000029', '2026-05-19', '2026-06-19', 10800000, 'Billing ke 17 dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079'),
(@5, 18, '2010.OPLAA.2402.000029', '2026-06-19', '2026-07-19', 10800000, 'Billing ke 18 dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079'),
(@5, 19, '2010.OPLAA.2402.000029', '2026-07-19', '2026-08-19', 10800000, 'Billing ke 19 dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079'),
(@5, 20, '2010.OPLAA.2402.000029', '2026-08-19', '2026-09-19', 10800000, 'Billing ke 20 dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079'),
(@5, 21, '2010.OPLAA.2402.000029', '2026-09-19', '2026-10-19', 10800000, 'Billing ke 21 dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079'),
(@5, 22, '2010.OPLAA.2402.000029', '2026-10-19', '2026-11-19', 10800000, 'Billing ke 22 dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079'),
(@5, 23, '2010.OPLAA.2402.000029', '2026-11-19', '2026-12-19', 10800000, 'Billing ke 23 dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079'),
(@5, 24, '2010.OPLAA.2402.000029', '2026-12-19', '2027-01-19', 10800000, 'Billing ke 24 dari Periode 23/09/2024 Sampai dengan 22/09/2025', getdate(), 'inject-fauzan', 'MYFORM-542079', getdate(), 'inject-fauzan', 'MYFORM-542079')
UPDATE dbo.AGREEMENT_INFORMATION SET MATURITY_DATE = '2027-01-19' WHERE AGREEMENT_NO = @5



SELECT	LEASE_ROUNDED_AMOUNT,BILLING_NO,AGREEMENT_ASSET.AGREEMENT_NO,AGREEMENT_ASSET.ASSET_NO,FIRST_PAYMENT_TYPE,BILLING_TYPE,HANDOVER_BAST_DATE,DUE_DATE,BILLING_DATE,BILLING_AMOUNT,dbo.AGREEMENT_ASSET_AMORTIZATION.INVOICE_NO,INVOICE_STATUS,MATURITY_DATE,AGREEMENT_ASSET_AMORTIZATION.MOD_BY, dbo.AGREEMENT_ASSET_AMORTIZATION.*
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
ORDER BY AGREEMENT_ASSET_AMORTIZATION.AGREEMENT_NO, dbo.AGREEMENT_ASSET_AMORTIZATION.BILLING_NO ASC
ROLLBACK TRANSACTION 