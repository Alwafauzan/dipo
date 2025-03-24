BEGIN TRANSACTION 
SELECT * FROM dbo.AGREEMENT_ASSET_AMORTIZATION where AGREEMENT_NO = '0000170.4.04.01.2023'
update dbo.AGREEMENT_ASSET_AMORTIZATION set DUE_DATE = '2025-03-31', BILLING_DATE = '2025-04-06', BILLING_AMOUNT = 3800000  , mod_date = GETDATE() ,mod_by = 'MTN_FAUZAN', mod_ip_address = 'MYFORM-532185' where AGREEMENT_NO = '0000170.4.04.01.2023' and BILLING_NO = 26
update dbo.AGREEMENT_ASSET_AMORTIZATION set DUE_DATE = '2025-04-30', BILLING_DATE = '2025-05-06', BILLING_AMOUNT = 3800000  , mod_date = GETDATE() ,mod_by = 'MTN_FAUZAN', mod_ip_address = 'MYFORM-532185' where AGREEMENT_NO = '0000170.4.04.01.2023' and BILLING_NO = 27
update dbo.AGREEMENT_ASSET_AMORTIZATION set DUE_DATE = '2025-05-31', BILLING_DATE = '2025-06-06', BILLING_AMOUNT = 3800000  , mod_date = GETDATE() ,mod_by = 'MTN_FAUZAN', mod_ip_address = 'MYFORM-532185' where AGREEMENT_NO = '0000170.4.04.01.2023' and BILLING_NO = 28
update dbo.AGREEMENT_ASSET_AMORTIZATION set DUE_DATE = '2025-06-30', BILLING_DATE = '2025-07-06', BILLING_AMOUNT = 3800000  , mod_date = GETDATE() ,mod_by = 'MTN_FAUZAN', mod_ip_address = 'MYFORM-532185' where AGREEMENT_NO = '0000170.4.04.01.2023' and BILLING_NO = 29
update dbo.AGREEMENT_ASSET_AMORTIZATION set DUE_DATE = '2025-07-06', BILLING_DATE = '2025-08-06', BILLING_AMOUNT = 678571   , mod_date = GETDATE() ,mod_by = 'MTN_FAUZAN', mod_ip_address = 'MYFORM-532185' where AGREEMENT_NO = '0000170.4.04.01.2023' and BILLING_NO = 30
SELECT * FROM dbo.AGREEMENT_ASSET_AMORTIZATION where AGREEMENT_NO = '0000170.4.04.01.2023'
------------------------------------------------------------------------------------------------
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
    'MTN MyForm 532185'
    ,'Revisi Schedule Billing Agreement No. 0000170/4/04/01/2023 PT. Kinarya Selaras Piranti'
    ,'AGREEMENT_ASSET_AMORTIZATION'
    ,'0002642.4.38.07.2024'
    ,null
    ,null
    ,GETDATE()
    ,'fauzan'
);
------------------------------------------------------------------------------------------------
ROLLBACK TRANSACTION 