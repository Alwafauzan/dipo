begin transaction 

select	* from dbo.PROCUREMENT_REQUEST_ITEM where PROCUREMENT_REQUEST_CODE = 'DSF.PRR.2502.000020' --edit specification, fa_code
update	dbo.PROCUREMENT_REQUEST_ITEM
set		SPECIFICATION				=	'Asset No : 2008.OPLAA.2501.000090 - Year : 2021 - Condition : USED - Colour : PUTIH.'
		,FA_CODE					=	'4120038983'
		,mod_date					=	getdate() 
		,mod_by						=	'MTN_FAUZAN'
		,mod_ip_address				=	'MYFORM-523399'
where	PROCUREMENT_REQUEST_CODE	=	'DSF.PRR.2502.000020'
SELECT	* FROM dbo.PROCUREMENT_REQUEST_ITEM where PROCUREMENT_REQUEST_CODE = 'DSF.PRR.2502.000020' --edit specification, fa_code

select	* from dbo.PROCUREMENT where CODE = 'DSF.PRC.2502.000007' --edit specification
update	dbo.PROCUREMENT
set		SPECIFICATION				=	'Asset No : 2008.OPLAA.2501.000090 - Year : 2021 - Condition : USED - Colour : PUTIH.'
		,mod_date					=	getdate() 
		,mod_by						=	'MTN_FAUZAN'
		,mod_ip_address				=	'MYFORM-523399'
where	CODE						=	'DSF.PRC.2502.000007'
select	* from dbo.PROCUREMENT where CODE = 'DSF.PRC.2502.000007' --edit specification

ROLLBACK TRANSACTION 

--SELECT	* FROM dbo.QUOTATION_REVIEW where CODE = 'DSF.QTR.2503.000101'
--SELECT	* FROM dbo.QUOTATION_REVIEW_DETAIL where QUOTATION_REVIEW_CODE = 'DSF.QTR.2503.000101'
--Mobilisasi Unit Sewa Untuk Application : 0003789/4/08/01/2025 - NAGA SAKTI SAMUDRA. Asset ALL NEW TRITON DC GLS 4X4 M/T (2.4L M/T) MODEL 2019 Mobilization to Pekanbaru Riau
--2008.OPLPUR.2502.000005
--2008.OPLAA.2501.000090
--0003789.4.08.01.2025
--0003789.4.08.01.2025
--4120038983
select	* FROM dbo.PROCUREMENT_REQUEST where CODE = 'DSF.PRR.2502.000020' --gaperlu diedit
------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--SELECT FA_REFF_NO_01,* FROM dbo.OPL_INTERFACE_PURCHASE_REQUEST where FA_REFF_NO_01 in ('BM8079QE', 'BM8257QE')
--select * FROM IFINPROC.dbo.PROC_INTERFACE_PURCHASE_REQUEST where CODE = '2008.OPLPUR.2502.000005'
--SELECT * FROM IFINAMS.dbo.ASSET_VEHICLE where PLAT_NO in ('BM8079QE', 'BM8257QE')
begin transaction 
select FA_REFF_NO_01,FA_REFF_NO_02,FA_REFF_NO_03,FA_REFF_NO_04,FA_REFF_NO_05,FA_REFF_NO_06,MOBILIZATION_FA_CODE,* from dbo.OPL_INTERFACE_PURCHASE_REQUEST where CODE = '2008.OPLPUR.2502.000005'
update	OPL_INTERFACE_PURCHASE_REQUEST
set		FA_REFF_NO_01			= 'BM8257QE'
		,FA_REFF_NO_02			= 'MMBJJKL10MH044259'
		,FA_REFF_NO_03			= '4N15UJC8866'
		,FA_REFF_NO_04			= '2021'
		,FA_REFF_NO_05			= 'USED'
		,FA_REFF_NO_06			= 'PUTIH'
		,MOBILIZATION_FA_CODE	= '4120038983'
		,mod_date				= getdate() 
		,mod_by					= 'MTN_FAUZAN'
		,mod_ip_address			= 'MYFORM-523399'
where	CODE					= '2008.OPLPUR.2502.000005'
SELECT FA_REFF_NO_01,FA_REFF_NO_02,FA_REFF_NO_03,FA_REFF_NO_04,FA_REFF_NO_05,FA_REFF_NO_06,MOBILIZATION_FA_CODE,* FROM dbo.OPL_INTERFACE_PURCHASE_REQUEST where CODE = '2008.OPLPUR.2502.000005'
select FA_REFF_NO_01,FA_REFF_NO_02,FA_REFF_NO_03,FA_REFF_NO_04,FA_REFF_NO_05,FA_REFF_NO_06,MOBILIZATION_FA_CODE,* FROM IFINPROC.dbo.PROC_INTERFACE_PURCHASE_REQUEST where CODE = '2008.OPLPUR.2502.000005'
update	IFINPROC.dbo.PROC_INTERFACE_PURCHASE_REQUEST
set		FA_REFF_NO_01			= 'BM8257QE'
		,FA_REFF_NO_02			= 'MMBJJKL10MH044259'
		,FA_REFF_NO_03			= '4N15UJC8866'
		,FA_REFF_NO_04			= '2021'
		,FA_REFF_NO_05			= 'USED'
		,FA_REFF_NO_06			= 'PUTIH'
		,MOBILIZATION_FA_CODE	= '4120038983'
where	CODE					= '2008.OPLPUR.2502.000005'
select FA_REFF_NO_01,FA_REFF_NO_02,FA_REFF_NO_03,FA_REFF_NO_04,FA_REFF_NO_05,FA_REFF_NO_06,MOBILIZATION_FA_CODE,* FROM IFINPROC.dbo.PROC_INTERFACE_PURCHASE_REQUEST where CODE = '2008.OPLPUR.2502.000005'
ROLLBACK TRANSACTION 

------------------------------------------------------------------------------------------------------------------------------------------------------------------------
BEGIN TRANSACTION 
SELECT FA_CODE,FA_REFF_NO_01,FA_REFF_NO_02,FA_REFF_NO_03,* FROM dbo.APPLICATION_ASSET
where ASSET_NO = '2008.OPLAA.2501.000090'

UPDATE dbo.APPLICATION_ASSET
set FA_REFF_NO_01		= 'BM8257QE'
	,FA_REFF_NO_02		= 'MMBJJKL10MH044259'
	,FA_REFF_NO_03		= '4N15UJC8866'
	,FA_CODE			= '4120038983'
	,mod_date           = getdate()
	,mod_by             = 'MTN_FAUZAN'
	,mod_ip_address     = 'MYFORM-523399'
where ASSET_NO = '2008.OPLAA.2501.000090'
 
select FA_CODE,FA_REFF_NO_01,FA_REFF_NO_02,FA_REFF_NO_03,* from dbo.APPLICATION_ASSET
where ASSET_NO = '2008.OPLAA.2501.000090'
 
select * from dbo.APPLICATION_ASSET_VEHICLE
where ASSET_NO = '2008.OPLAA.2501.000090'
 
update dbo.APPLICATION_ASSET_VEHICLE
set VEHICLE_MODEL_CODE = 'V-001.L20'
	,VEHICLE_TYPE_CODE = 'V-001.L20.TDGS4M'
	,COLOUR = 'PUTIH'
	,mod_date           = getdate()
	,mod_by             = 'MTN_FAUZAN'
	,mod_ip_address     = 'MYFORM-523399'
where ASSET_NO = '2008.OPLAA.2501.000090'
 
select * from dbo.APPLICATION_ASSET_VEHICLE
where ASSET_NO = '2008.OPLAA.2501.000090'
 
select * from IFINAMS.dbo.HANDOVER_REQUEST
where ASSET_NO = '2008.OPLAA.2501.000090'
 
update IFINAMS.dbo.HANDOVER_REQUEST
set FA_CODE = '4120038983'
	,mod_date           = GETDATE()
	,mod_by             = 'MTN_FAUZAN'
	,mod_ip_address     = 'MYFORM-523399'
where ASSET_NO = '2008.OPLAA.2501.000090'
 
SELECT * FROM IFINAMS.dbo.HANDOVER_REQUEST
where ASSET_NO = '2008.OPLAA.2501.000090'
 
 
 
  INSERT INTO MTN_DATA_DSF_LOG
  ( -- columns to insert data into
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
  ( -- first row: values for the columns in the list above
  'MTN MyForm 523399'
  ,'Revisi billing date untuk kontrak 0002983/4/38/10/2024'-- GANTI INI DENGAN ISSUENYA YANG REAL
  ,'AGREEMENT_ASSET_AMORTIZATION' -- GANTI INI DENGAN ISSUENYA YANG REAL
  ,'2008.OPLAA.2501.000090' 
  ,null
  ,null
  ,GETDATE()
  ,'fauzan'
  );
ROLLBACK transaction

------------------------------------------------------------------------------------------------------------------------------------------------------------------------


SELECT FA_REFF_NO_01,ASSET_CONDITION,* FROM dbo.APPLICATION_ASSET where FA_REFF_NO_01 in ('BM8079QE', 'BM8257QE')
SELECT * FROM dbo.APPLICATION_ASSET_VEHICLE where ASSET_NO = '2008.OPLAA.2501.000090'

BEGIN TRANSACTION 
DECLARE @val VARCHAR(50);

DECLARE reff_cursor CURSOR FOR
SELECT VAL
FROM (
    VALUES
    ('4120038983')
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
        'MTN MyForm 523399'
        ,'Revisi Nopol Untuk aplikasi 0003789/4/08/01/2025 dengan no asset 2008.OPLAA.2501.000090 menjadi BM8257QE dan untuk realization, agar no kontraknya menjadi 0003747/4/08/01/2025'
        ,'AGREEMENT_ASSET_AMORTIZATION'
        ,'2008.OPLAA.2501.000090'
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