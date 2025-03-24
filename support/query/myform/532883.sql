BEGIN TRANSACTION 
select * FROM dbo.AGREEMENT_ASSET_AMORTIZATION where AGREEMENT_NO = '0001216.4.01.01.2023'
select * FROM dbo.AGREEMENT_ASSET_AMORTIZATION where AGREEMENT_NO = '0001215.4.01.01.2023'

update AGREEMENT_ASSET_AMORTIZATION set DUE_DATE = convert(datetime, '28/02/2025', 103), BILLING_DATE = convert(datetime, '28/02/2025', 103), BILLING_AMOUNT =  6700000, mod_date = GETDATE() ,mod_by = 'MTN_FAUZAN', mod_ip_address = 'MYFORM-532883' 
where AGREEMENT_NO = '0001216.4.01.01.2023' and BILLING_NO = 25
update AGREEMENT_ASSET_AMORTIZATION set DUE_DATE = convert(datetime, '28/03/2025', 103), BILLING_DATE = convert(datetime, '28/03/2025', 103), BILLING_AMOUNT =   6460714, mod_date = GETDATE() ,mod_by = 'MTN_FAUZAN', mod_ip_address = 'MYFORM-532883' 
where AGREEMENT_NO = '0001216.4.01.01.2023' and BILLING_NO = 26

update AGREEMENT_ASSET_AMORTIZATION set DUE_DATE = convert(datetime, '28/02/2025', 103), BILLING_DATE = convert(datetime, '28/02/2025', 103), BILLING_AMOUNT =   5150000, mod_date = GETDATE() ,mod_by = 'MTN_FAUZAN', mod_ip_address = 'MYFORM-532883' 
where AGREEMENT_NO = '0001215.4.01.01.2023' and BILLING_NO = 25
update AGREEMENT_ASSET_AMORTIZATION set DUE_DATE = convert(datetime, '25/03/2025', 103), BILLING_DATE = convert(datetime, '25/03/2025', 103), BILLING_AMOUNT =   4414286, mod_date = GETDATE() ,mod_by = 'MTN_FAUZAN', mod_ip_address = 'MYFORM-532883' 
where AGREEMENT_NO = '0001215.4.01.01.2023' and BILLING_NO = 26


select * FROM dbo.AGREEMENT_ASSET_AMORTIZATION where AGREEMENT_NO = '0001216.4.01.01.2023'
select * FROM dbo.AGREEMENT_ASSET_AMORTIZATION where AGREEMENT_NO = '0001215.4.01.01.2023'

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
    'MTN MYFORM-532883'
    ,'Req Revisi Schedule Billing 0001216/4/01/01/2023 dan 0001215/4/01/01/2023 PT. ANDIARTA MUZIZAT Dikarenakan schedule billing tidak sesuai setelah dilakukan extend 1 bulan'
    ,'AGREEMENT_ASSET_AMORTIZATION'
    ,'0001216.4.01.01.2023'
    ,null
    ,null
    ,GETDATE()
    ,'fauzan'
);
------------------------------------------------------------------------------------------------
ROLLBACK TRANSACTION