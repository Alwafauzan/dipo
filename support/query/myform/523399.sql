BEGIN TRANSACTION 
SELECT FA_CODE,FA_REFF_NO_01,FA_REFF_NO_02,FA_REFF_NO_03,* FROM dbo.APPLICATION_ASSET
where ASSET_NO          = '2008.OPLAA.2501.000090'

UPDATE dbo.APPLICATION_ASSET
set FA_REFF_NO_01		    = 'BM8257QE'
	,FA_REFF_NO_02		    = 'MMBJJKL10MH044259'
	,FA_REFF_NO_03		    = '4N15UJC8866'
	,FA_CODE			        = '4120038983'
	,mod_date             = GETDATE()
	,mod_by               = 'MTN_FAUZAN'
	,mod_ip_address       = 'MYFORM-523399'
where ASSET_NO          = '2008.OPLAA.2501.000090'
 
SELECT FA_CODE,FA_REFF_NO_01,FA_REFF_NO_02,FA_REFF_NO_03,* FROM dbo.APPLICATION_ASSET
where ASSET_NO          = '2008.OPLAA.2501.000090'
 
SELECT * FROM dbo.APPLICATION_ASSET_VEHICLE
where ASSET_NO          = '2008.OPLAA.2501.000090'
 
update dbo.APPLICATION_ASSET_VEHICLE
set VEHICLE_MODEL_CODE  = 'V-001.L20'
	,VEHICLE_TYPE_CODE    = 'V-001.L20.TDGS4M'
	,COLOUR               = 'PUTIH'
	,mod_date             = GETDATE()
	,mod_by               = 'MTN_FAUZAN'
	,mod_ip_address       = 'MYFORM-523399'
where ASSET_NO          = '2008.OPLAA.2501.000090'
 
SELECT * FROM dbo.APPLICATION_ASSET_VEHICLE
where ASSET_NO          = '2008.OPLAA.2501.000090'
 
SELECT * FROM IFINAMS.dbo.HANDOVER_REQUEST
where ASSET_NO          = '2008.OPLAA.2501.000090'
 
update IFINAMS.dbo.HANDOVER_REQUEST
set FA_CODE             = '4120038983'
	,mod_date             = GETDATE()
	,mod_by               = 'MTN_FAUZAN'
	,mod_ip_address       = 'MYFORM-523399'
where ASSET_NO          = '2008.OPLAA.2501.000090'
 
SELECT * FROM IFINAMS.dbo.HANDOVER_REQUEST
where ASSET_NO          = '2008.OPLAA.2501.000090'
 
 
 
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
ROLLBACK TRANSACTION