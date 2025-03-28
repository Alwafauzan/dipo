--BEGIN TRANSACTION 

-- bast
select HANDOVER_BAST_DATE,* FROM dbo.AGREEMENT_ASSET where AGREEMENT_NO = '0003699.4.10.01.2025'
update dbo.AGREEMENT_ASSET set HANDOVER_BAST_DATE = '2025-01-30', mod_date = GETDATE() ,mod_by = 'MTN_FAUZAN', mod_ip_address = 'MYFORM-532155' where AGREEMENT_NO = '0003699.4.10.01.2025'
select HANDOVER_BAST_DATE,* FROM dbo.AGREEMENT_ASSET where AGREEMENT_NO = '0003699.4.10.01.2025'
-- amort
select * FROM dbo.AGREEMENT_ASSET_AMORTIZATION where AGREEMENT_NO = '0003699.4.10.01.2025'
UPDATE AGREEMENT_ASSET_AMORTIZATION SET DUE_DATE = EOMONTH(DUE_DATE), BILLING_DATE = EOMONTH(BILLING_DATE), mod_date = GETDATE() ,mod_by = 'MTN_FAUZAN', mod_ip_address = 'MYFORM-532155' where AGREEMENT_NO = '0003699.4.10.01.2025'
-- desc amort
UPDATE  AGREEMENT_ASSET_AMORTIZATION
SET    DESCRIPTION  = 'Billing ke ' + CAST(artz.BILLING_NO AS NVARCHAR(2)) + ' dari Periode ' + CONVERT(NVARCHAR(10), period.period_date, 103) + ' sampai dengan ' + CONVERT(NVARCHAR(10), period.period_due_date, 103)
from  dbo.AGREEMENT_ASSET_AMORTIZATION artz 
    inner join dbo.agreement_main am on (am.agreement_no = artz.agreement_no)
    outer apply
    (
      select  billing_no
          ,case am.first_payment_type
             when 'ARR' then period_date + 1
             else period_date
           end 'period_date'
           ,aa.period_due_date
      from  dbo.xfn_due_date_period(artz.asset_no, cast(artz.billing_no as int)) aa
      where  artz.asset_no = artz.asset_no
      and    aa.billing_no = artz.billing_no
    ) period
where  artz.MOD_BY = 'MTN_FAUZAN' AND CAST(artz.MOD_DATE AS DATE) = CAST(GETDATE() AS DATE) AND am.AGREEMENT_NO =  '0003699.4.10.01.2025';
select * FROM dbo.AGREEMENT_ASSET_AMORTIZATION where AGREEMENT_NO = '0003699.4.10.01.2025'
-- maturity
select MATURITY_DATE,* FROM dbo.AGREEMENT_INFORMATION where AGREEMENT_NO = '0003699.4.10.01.2025'
update dbo.AGREEMENT_INFORMATION set MATURITY_DATE = '2028-01-31', mod_date = GETDATE() ,mod_by = 'MTN_FAUZAN', mod_ip_address = 'MYFORM-532155' where AGREEMENT_NO = '0003699.4.10.01.2025'
select MATURITY_DATE,* FROM dbo.AGREEMENT_INFORMATION where AGREEMENT_NO = '0003699.4.10.01.2025'
--mtn log
DECLARE @val VARCHAR(50);

DECLARE reff_cursor CURSOR FOR
SELECT VAL
FROM (
    VALUES
    ('B9544PXA')
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
        'MTN MyForm 532155'
        ,' Revisi BAST Date dan Schedule Billing Kopsi B9544PXA'
        ,'AGREEMENT_ASSET_AMORTIZATION'
        ,'0003699/4/10/01/2025'
        ,@val
        ,null
        ,GETDATE()
        ,'fauzan'
    );

    FETCH NEXT FROM reff_cursor INTO @val;
END

CLOSE reff_cursor;
DEALLOCATE reff_cursor;
--ROLLBACK TRANSACTION 