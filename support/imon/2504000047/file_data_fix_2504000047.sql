BEGIN TRANSACTION 
DECLARE @assetno NVARCHAR(50) = '2010.OPLAA.2502.000194'
SELECT FA_CODE,FA_REFF_NO_01,FA_REFF_NO_02,FA_REFF_NO_03,* FROM dbo.APPLICATION_ASSET
where ASSET_NO          = @assetno

UPDATE dbo.APPLICATION_ASSET
set FA_REFF_NO_01		    = 'B1298DFC'
	,FA_REFF_NO_02		    = 'MHKM5EB3JMK036614'
	,FA_REFF_NO_03		    = '1NRG156612'
	,FA_CODE			        = '4120037795'
	,mod_date             = GETDATE()
	,mod_by               = 'MTN_FAUZAN'
	,mod_ip_address       = '2504000047'
where ASSET_NO          = @assetno
 
SELECT FA_CODE,FA_REFF_NO_01,FA_REFF_NO_02,FA_REFF_NO_03,* FROM dbo.APPLICATION_ASSET
where ASSET_NO          = @assetno
 
SELECT * FROM dbo.APPLICATION_ASSET_VEHICLE
where ASSET_NO          = @assetno
 
update dbo.APPLICATION_ASSET_VEHICLE
set VEHICLE_MODEL_CODE  = 'V-002.AVZ'
	,VEHICLE_TYPE_CODE    = 'V-002.AVZ.AV13GA'
	,COLOUR               = 'HITAM METALIK'
	,mod_date             = GETDATE()
	,mod_by               = 'MTN_FAUZAN'
	,mod_ip_address       = '2504000047'
where ASSET_NO          = @assetno
 
SELECT * FROM dbo.APPLICATION_ASSET_VEHICLE
where ASSET_NO          = @assetno
 
SELECT * FROM IFINAMS.dbo.HANDOVER_REQUEST
where ASSET_NO          = @assetno
 
update IFINAMS.dbo.HANDOVER_REQUEST
set FA_CODE             = '4120038983'
	,mod_date             = GETDATE()
	,mod_by               = 'MTN_FAUZAN'
	,mod_ip_address       = '2504000047'
where ASSET_NO          = @assetno
 
SELECT * FROM IFINAMS.dbo.HANDOVER_REQUEST
where ASSET_NO          = @assetno
 
 
 
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
  '2504000047'
  ,'Revisi billing date untuk kontrak 0002983/4/38/10/2024'-- GANTI INI DENGAN ISSUENYA YANG REAL
  ,'AGREEMENT_ASSET_AMORTIZATION' -- GANTI INI DENGAN ISSUENYA YANG REAL
  ,@assetno 
  ,null
  ,null
  ,GETDATE()
  ,'fauzan'
  );
ROLLBACK TRANSACTION